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
import 'package:ac_mobile_final/pages/airplaneOps//detail.dart';
import 'package:ac_mobile_final/pages/airplaneOps/input.dart';
import 'package:ac_mobile_final/pages/airplaneOps/update.dart';

/// The main page to manage airplanes.
///
/// Provides insert, update, and detail view of airplane records.
class AirplanePage extends StatefulWidget {
  /// Creates a [AirplanePage].
  const AirplanePage({
    super.key,
  });

  @override
  State<AirplanePage> createState() => _AirplanePageState();
}

class _AirplanePageState extends State<AirplanePage> {
  /// UUID generator for airplane IDs.
  final uuid = Uuid();
  /// Data source instance to interact with the backend.
  final DataSource _dataSource = DataSource.instance;

  // Controllers for insert.
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _speedController = TextEditingController();
  final TextEditingController _rangeController = TextEditingController();

  // Controllers for update.
  final TextEditingController _modelUpdate = TextEditingController();
  final TextEditingController _capacityUpdate = TextEditingController();
  final TextEditingController _speedUpdate = TextEditingController();
  final TextEditingController _rangeUpdate = TextEditingController();

  /// List of all airplane records.
  List<Airplane> airplanes = [];
  /// List of all flights records.
  List<Flight> flights = [];
  /// Currently selected airplane for detail.
  Airplane? selectedAirplane;


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await _dataSource.syncAll();
      await AppCache.syncFromAirplaneCache();


      flights = DataSource.flights;

      setState(() {
        airplanes = DataSource.airplanes;

        if (AppCache.model != '') _modelController.text = AppCache.model;
        if (AppCache.capacity != 0) _capacityController.text = AppCache.capacity.toString();
        if (AppCache.speed != 0) _speedController.text = AppCache.speed.toString();
        if (AppCache.range != 0) _rangeController.text = AppCache.range.toString();
      });
    });
  }

  @override
  void dispose() {
    _modelController.dispose();
    _capacityController.dispose();
    _speedController.dispose();
    _rangeController.dispose();
    _modelUpdate.dispose();
    _capacityUpdate.dispose();
    _speedUpdate.dispose();
    _rangeUpdate.dispose();
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
        selectedAirplane = null;
      });
    }

    /// Selects an airplane to show details.
    void selected(Airplane airplane) {
      setState(() {
        selectedAirplane = airplane;
      });
    }

    /// Deletes an airplane if no reservation is linked.
    Future<void> removeAirplane(Airplane? airplane) async {
      if (airplane == null) return;

      Flight? targetReservation = flights
          .cast<Flight?>()
          .firstWhere((res) => res?.model == airplane.model,
        orElse: () => null,
      );

      if (targetReservation == null) {
        await _dataSource.deleteAirplane(airplane);

        setState(() {
          airplanes = DataSource.airplanes;
        });
      } else {
        SnackMessage.showMessage(
            context,
            localizations.msg2airplaneHasFlight,
            3
        );
      }
    }

    /// Inserts a new airplane based on the form inputs.
    Future<void> insertAirplane() async {
      if (_modelController.text.trim().isEmpty) {
        SnackMessage.showMessage(context, localizations.msg2noModel, 1);
        return;
      }

      if (_capacityController.text.trim().isEmpty) {
        SnackMessage.showMessage(context, localizations.msg2noCapacity, 1);
        return;
      }

      if (_speedController.text.trim().isEmpty) {
        SnackMessage.showMessage(context, localizations.msg2noSpeed, 1);
        return;
      }

      if (_rangeController.text.trim().isEmpty) {
        SnackMessage.showMessage(context, localizations.msg2noRange, 1);
        return;
      }

      await _dataSource.addAirplane(
        Airplane(
          id: uuid.v1(),
          model: _modelController.text,
          capacity: int.parse(_capacityController.text),
          maxSpeed: int.parse(_speedController.text),
          range: int.parse(_rangeController.text),
        ),
      );

      AppCache.model = _modelController.text;
      AppCache.capacity = int.parse(_capacityController.text);
      AppCache.speed = int.parse(_speedController.text);
      AppCache.range = int.parse(_rangeController.text);

      await AppCache.syncToAirplaneCache();

      SnackMessage.showMessage(context, localizations.msg2addAirplane, 2);

      setState(() {
        airplanes = DataSource.airplanes;
      });
    }

    /// Updates an existing airplane with the new form values.
    Future<void> updateAirplane(Airplane airplane) async {
      if (_modelUpdate.text.trim().isEmpty &&
          _capacityUpdate.text.trim().isEmpty &&
          _speedUpdate.text.trim().isEmpty &&
          _rangeUpdate.text.trim().isEmpty
      ) {
        SnackMessage.showMessage(context, localizations.msg2noUpdateAirplane, 2);
        return;
      }

      String newModel = airplane.model;
      int newCapacity = airplane.capacity;
      int newSpeed = airplane.maxSpeed;
      int newRange = airplane.range;

      if (_modelUpdate.text.trim().isNotEmpty) newModel = _modelUpdate.text;
      if (_capacityUpdate.text.trim().isNotEmpty) newCapacity = int.parse(_capacityUpdate.text);
      if (_speedUpdate.text.trim().isNotEmpty) newSpeed = int.parse(_speedUpdate.text);
      if (_rangeUpdate.text.trim().isNotEmpty) newRange = int.parse(_rangeUpdate.text);

      Flight? targetReservation = flights
          .cast<Flight?>()
          .firstWhere((res) => res?.model == airplane.model,
        orElse: () => null,
      );

      if (targetReservation != null) {
        SnackMessage.showMessage(
            context,
            localizations.msg2airplaneHasFlightNoUpdate,
            3
        );
        return;
      }

      await _dataSource.updateAirplane(
        Airplane(
          id: airplane.id,
          model: newModel,
          capacity: newCapacity,
          maxSpeed: newSpeed,
          range: newRange,
        ),
      );

      setState(() {
        airplanes = DataSource.airplanes;
        _modelUpdate.clear();
        _capacityUpdate.clear();
        _speedUpdate.clear();
        _rangeUpdate.clear();
      });
    }

    /// Resets the airplane form and clears cached fields.
    Future<void> resetAirplane() async {
      AppCache.model = '';
      AppCache.capacity = 0;
      AppCache.speed = 0;
      AppCache.range = 0;
      await AppCache.syncToAirplaneCache();

      setState(() {
        _modelController.clear();
        _capacityController.clear();
        _speedController.clear();
        _rangeController.clear();
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
                    'assets/images/airplane_btn.png',
                    height: 150,
                    fit: BoxFit.cover,
                  )
              ),
              InputsBar(
                modelController: _modelController,
                capacityController: _capacityController,
                speedController: _speedController,
                rangeController: _rangeController,
                onClick: insertAirplane,
                onReset: resetAirplane,
              ),
              ...airplanes.asMap().entries.map((entry) => Container(
                margin: EdgeInsets.all(10.0),
                child: Card(
                  elevation: 0.5,
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    title: Text(
                      entry.value.model,
                      style: GoogleFonts.roboto(),
                    ),
                    subtitle: Text(
                      '${entry.value.maxSpeed.toString()} KM/h -> ${entry.value.range.toString()} KMs',
                      style: GoogleFonts.roboto(),
                    ),
                    onLongPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateAirplane(
                            onUpdate: () => updateAirplane(entry.value),
                            airplane: entry.value,
                            modelController: _modelUpdate,
                            capacityController: _capacityUpdate,
                            speedController: _speedUpdate,
                            rangeController: _rangeUpdate,
                          ),
                        ),
                      );
                    },
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AirplaneDetail(
                                airplane: entry.value,
                                onCancel: unselect,
                                onRemove: () => removeAirplane(entry.value),
                                navBar: true,
                                goBack: true,
                              )
                          )
                      );
                    },
                  ),
                ),
              )),
              CopyrightFooter(content: localizations.copyright),
            ],
          ),
        )
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
                        'assets/images/airplane_btn.png',
                        height: 150,
                        fit: BoxFit.cover,
                      )
                  ),
                  InputsBar(
                    modelController: _modelController,
                    capacityController: _capacityController,
                    speedController: _speedController,
                    rangeController: _rangeController,
                    onClick: insertAirplane,
                    onReset: resetAirplane,
                  ),
                  ...airplanes.asMap().entries.map((entry) => Container(
                    margin: EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 0.5,
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        title: Text(
                          entry.value.model,
                          style: GoogleFonts.roboto(),
                        ),
                        subtitle: Text(
                          '${entry.value.maxSpeed.toString()} KM/h -> ${entry.value.range.toString()} KMs',
                          style: GoogleFonts.roboto(),
                        ),
                        onLongPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateAirplane(
                                onUpdate: () => updateAirplane(entry.value),
                                airplane: entry.value,
                                modelController: _modelUpdate,
                                capacityController: _capacityUpdate,
                                speedController: _speedUpdate,
                                rangeController: _rangeUpdate,
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
            child: AirplaneDetail(
              airplane: selectedAirplane,
              onCancel: unselect,
              onRemove: () => removeAirplane(selectedAirplane),
              navBar: false,
              goBack: false,
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: MainNav(
        title: localizations.btn2airplane,
        returnButton: true,
      ),
      body: tabletLayout ? landscapeView : portraitView,
    );
  }
}