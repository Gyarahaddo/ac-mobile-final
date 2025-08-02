/// CST2335 Final Project.
///
/// Created: July 25, 2025
/// Group Members:
///  - Lingfeng "Galahad" Zhao (zhao0291@algonquinlive.com)
///  - Jesse Proulx (prou0212@algonquinlive.com)
///  - Xinghan Xu (xu000334@algonquinlive.com)
///  - Luca Barbesin (barb0285@algonquinlive.com)
library;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:ac_mobile_final/components/navbar.dart';
import 'package:ac_mobile_final/components/message.dart';
import 'package:ac_mobile_final/components/footer.dart';
import 'package:ac_mobile_final/services/datasource.dart';
import 'package:ac_mobile_final/services/appcache.dart';
import 'package:ac_mobile_final/schemas/airplane.dart';
import 'package:ac_mobile_final/schemas/flight.dart';
import 'package:ac_mobile_final/schemas/reservation.dart';
import 'package:ac_mobile_final/pages/flightOps/detail.dart';
import 'package:ac_mobile_final/pages/flightOps/input.dart';
import 'package:ac_mobile_final/pages/flightOps/update.dart';

/// The main page to manage flights.
///
/// Provides insert, update, and detail view of flight records.
class FlightPage extends StatefulWidget {
  /// Creates a [FlightPage].
  const FlightPage({
    super.key,
  });

  @override
  State<FlightPage> createState() => _FlightPageState();
}

class _FlightPageState extends State<FlightPage> {
  /// UUID generator for flight IDs.
  final uuid = Uuid();
  /// Data source instance to interact with the backend.
  final DataSource _dataSource = DataSource.instance;

  // Controllers for insert.
  final TextEditingController _flightCodeController = TextEditingController();
  final TextEditingController _fromCityController = TextEditingController();
  final TextEditingController _toCityController = TextEditingController();
  final TextEditingController _departureTimeController = TextEditingController();
  final TextEditingController _arrivalTimeController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();

  // Controllers for update.
  final TextEditingController _flightCodeUpdate = TextEditingController();
  final TextEditingController _fromCityUpdate = TextEditingController();
  final TextEditingController _toCityUpdate = TextEditingController();
  final TextEditingController _departureTimeUpdate = TextEditingController();
  final TextEditingController _arrivalTimeUpdate = TextEditingController();
  final TextEditingController _modelUpdate = TextEditingController();

  /// List of all airplane records.
  List<Airplane> airplanes = [];
  /// List of all flights records.
  List<Flight> flights = [];
  /// List of all flights records.
  List<Reservation> reservations = [];
  /// Currently selected airplane for detail.
  Flight? selectedFlight;


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await _dataSource.syncAll();
      await AppCache.syncFromFlightCache();

      airplanes = DataSource.airplanes;
      reservations = DataSource.reservations;

      setState(() {
        flights = DataSource.flights;

        if (AppCache.flightCode != '') _flightCodeController.text = AppCache.flightCode;
        if (AppCache.fromCity != '') _fromCityController.text = AppCache.fromCity;
        if (AppCache.toCity != '') _toCityController.text = AppCache.toCity;
        if (AppCache.departureTime != '') _departureTimeController.text = AppCache.departureTime;
        if (AppCache.arrivalTime != '') _arrivalTimeController.text = AppCache.arrivalTime;
        if (AppCache.assignedModel != '') _modelController.text = AppCache.assignedModel;
      });
    });
  }

  @override
  void dispose() {
    _flightCodeController.dispose();
    _fromCityController.dispose();
    _toCityController.dispose();
    _departureTimeController.dispose();
    _arrivalTimeController.dispose();
    _modelController.dispose();

    _flightCodeUpdate.dispose();
    _fromCityUpdate.dispose();
    _toCityUpdate.dispose();
    _departureTimeUpdate.dispose();
    _arrivalTimeUpdate.dispose();
    _modelUpdate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool tabletLayout = screenWidth > 600;

    final localizations = AppLocalizations.of(context)!;

    /// Clears the current selection.
    void unselect() {
      setState(() {
        selectedFlight = null;
      });
    }

    /// Selects a flight to show details.
    void selected(Flight flight) {
      setState(() {
        selectedFlight = flight;
      });
    }

    /// Deletes a flight if no reservation is linked.
    Future<void> removeFlight(Flight? flight) async {
      if (flight == null) return;

      Reservation? targetReservation = reservations
          .cast<Reservation?>()
          .firstWhere((res) => res?.flightCode == flight.id,
        orElse: () => null,
      );

      if (targetReservation == null) {
        await _dataSource.deleteFlight(flight);

        setState(() {
          flights = DataSource.flights;
        });
      } else {
        SnackMessage.showMessage(
            context,
            localizations.msg2flightHasReservation,
            3
        );
      }
    }

    /// Inserts a new flight based on the form inputs.
    Future<void> insertFlight() async {
      if (_flightCodeController.text.trim().isEmpty) {
        SnackMessage.showMessage(context, localizations.msg2noFlightCode, 1);
        return;
      }

      if (_fromCityController.text.trim().isEmpty) {
        SnackMessage.showMessage(context, localizations.msg2noFromCity, 1);
        return;
      }

      if (_toCityController.text.trim().isEmpty) {
        SnackMessage.showMessage(context, localizations.msg2noToCity, 1);
        return;
      }

      if (_departureTimeController.text.trim().isEmpty) {
        SnackMessage.showMessage(context, localizations.msg2noDepartureTime, 1);
        return;
      }

      if (_arrivalTimeController.text.trim().isEmpty) {
        SnackMessage.showMessage(context, localizations.msg2noArrivalTime, 1);
        return;
      }

      if (_modelController.text.trim().isEmpty) {
        SnackMessage.showMessage(context, localizations.msg2noAssignedModel, 1);
        return;
      }

      Airplane? targetModel = airplanes
          .cast<Airplane?>()
          .firstWhere((air) => air?.model == _modelController.text,
        orElse: () => null,
      );

      if (targetModel == null) {
        SnackMessage.showMessage(context, localizations.msg2noSuchModel, 1);
        return;
      }

      await _dataSource.addFlight(
        Flight(
          id: uuid.v1(),
          flightCode: _flightCodeController.text,
          fromCity: _fromCityController.text,
          toCity: _toCityController.text,
          departureTime: _departureTimeController.text,
          arrivalTime: _arrivalTimeController.text,
          model: _modelController.text,
        ),
      );

      AppCache.flightCode = _flightCodeController.text;
      AppCache.fromCity = _fromCityController.text;
      AppCache.toCity = _toCityController.text;
      AppCache.departureTime = _departureTimeController.text;
      AppCache.arrivalTime = _arrivalTimeController.text;
      AppCache.assignedModel = _modelController.text;

      await AppCache.syncToFlightCache();

      SnackMessage.showMessage(context, localizations.msg2addFlight, 2);

      setState(() {
        flights = DataSource.flights;
      });
    }

    /// Updates an existing flight with the new form values.
    Future<void> updateFlight(Flight flight) async {
      if (_flightCodeUpdate.text.trim().isEmpty &&
          _fromCityUpdate.text.trim().isEmpty &&
          _toCityUpdate.text.trim().isEmpty &&
          _departureTimeUpdate.text.trim().isEmpty &&
          _arrivalTimeUpdate.text.trim().isEmpty &&
          _modelUpdate.text.trim().isEmpty
      ) {
        SnackMessage.showMessage(context, localizations.msg2noUpdateFlight, 2);
        return;
      }

      String newFlightCode = flight.flightCode;
      String newFromCity = flight.fromCity;
      String newToCity = flight.toCity;
      String newDepartureTime = flight.departureTime;
      String newArrivalTime = flight.arrivalTime;
      String newModel = flight.model;

      if (_flightCodeUpdate.text.trim().isNotEmpty) newFlightCode = _flightCodeUpdate.text;
      if (_fromCityUpdate.text.trim().isNotEmpty) newFromCity = _fromCityUpdate.text;
      if (_toCityUpdate.text.trim().isNotEmpty) newToCity = _toCityUpdate.text;
      if (_departureTimeUpdate.text.trim().isNotEmpty) newDepartureTime = _departureTimeUpdate.text;
      if (_arrivalTimeUpdate.text.trim().isNotEmpty) newArrivalTime = _arrivalTimeUpdate.text;
      if (_modelUpdate.text.trim().isNotEmpty) newModel = _modelUpdate.text;

      Airplane? targetModel = airplanes
          .cast<Airplane?>()
          .firstWhere((air) => air?.model == _modelController.text,
        orElse: () => null,
      );

      if (targetModel == null) {
        SnackMessage.showMessage(context, localizations.msg2noSuchModel, 1);
        return;
      }

      await _dataSource.updateFlight(
        Flight(
          id: flight.id,
          flightCode: newFlightCode,
          fromCity: newFromCity,
          toCity: newToCity,
          departureTime: newDepartureTime,
          arrivalTime: newArrivalTime,
          model: newModel,
        ),
      );

      setState(() {
        flights = DataSource.flights;
        _flightCodeUpdate.clear();
        _fromCityUpdate.clear();
        _toCityUpdate.clear();
        _departureTimeUpdate.clear();
        _arrivalTimeUpdate.clear();
        _modelUpdate.clear();
      });
    }

    /// Resets the flight form and clears cached fields.
    Future<void> resetFlight() async {
      AppCache.flightCode = '';
      AppCache.fromCity = '';
      AppCache.toCity = '';
      AppCache.departureTime = '';
      AppCache.arrivalTime = '';
      AppCache.assignedModel = '';
      await AppCache.syncToFlightCache();

      setState(() {
        _flightCodeController.clear();
        _fromCityController.clear();
        _toCityController.clear();
        _departureTimeController.clear();
        _arrivalTimeController.clear();
        _modelController.clear();
      });
    }

    final portraitView = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 0.5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                'assets/images/flight_btn.png',
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            InputsBar(
              flightCodeController: _flightCodeController,
              fromCityController: _fromCityController,
              toCityController: _toCityController,
              departureTimeController: _departureTimeController,
              arrivalTimeController: _arrivalTimeController,
              assignedModelController: _modelController,
              onClick: insertFlight,
              onReset: resetFlight,
            ),
            ...flights.asMap().entries.map((entry) => Container(
              margin: EdgeInsets.all(10.0),
              child: Card(
                elevation: 0.5,
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Text(
                    entry.value.flightCode,
                    style: GoogleFonts.roboto(),
                  ),
                  subtitle: Text(
                    '${entry.value.fromCity} -> ${entry.value.toCity}',
                    style: GoogleFonts.roboto(),
                  ),
                  onLongPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateFlight(
                          onUpdate: () => updateFlight(entry.value),
                          flight: entry.value,
                          flightCodeController: _flightCodeUpdate,
                          fromCityController: _fromCityUpdate,
                          toCityController: _toCityUpdate,
                          departureTimeController: _departureTimeUpdate,
                          arrivalTimeController: _arrivalTimeUpdate,
                          assignedModelController: _modelUpdate,
                        ),
                      ),
                    );},
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FlightDetail(
                            flight: entry.value,
                            onCancel: unselect,
                            onRemove: () => removeFlight(entry.value),
                            navBar: true,
                            goBack: true,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )),
              CopyrightFooter(content: localizations.copyright),
            ],
          ),
        ),
    );

    final landscapeView = SafeArea(
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    elevation: 0.5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      'assets/images/flight_btn.png',
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  InputsBar(
                    flightCodeController: _flightCodeController,
                    fromCityController: _fromCityController,
                    toCityController: _toCityController,
                    departureTimeController: _departureTimeController,
                    arrivalTimeController: _arrivalTimeController,
                    assignedModelController: _modelController,
                    onClick: insertFlight,
                    onReset: resetFlight,
                  ),
                  ...flights.asMap().entries.map((entry) => Container(
                    margin: EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 0.5,
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        title: Text(
                          entry.value.flightCode,
                          style: GoogleFonts.roboto(),
                        ),
                        subtitle: Text(
                          '${entry.value.fromCity} -> ${entry.value.toCity}',
                          style: GoogleFonts.roboto(),
                        ),
                        onLongPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateFlight(
                                onUpdate: () => updateFlight(entry.value),
                                flight: entry.value,
                                flightCodeController: _flightCodeUpdate,
                                fromCityController: _fromCityUpdate,
                                toCityController: _toCityUpdate,
                                departureTimeController: _departureTimeUpdate,
                                arrivalTimeController: _arrivalTimeUpdate,
                                assignedModelController: _modelUpdate,
                              ),
                            ),
                          );
                        },
                        onTap: () {
                          selected(entry.value);
                        },
                      ),
                    ),
                  )),
                  CopyrightFooter(content: localizations.copyright),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: FlightDetail(
              flight: selectedFlight,
              onCancel: unselect,
              onRemove: () => removeFlight(selectedFlight),
              navBar: false,
              goBack: false,
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: MainNav(
        title: localizations.btn2flight,
        returnButton: true,
      ),
      body: tabletLayout ? landscapeView : portraitView,
    );
  }
}