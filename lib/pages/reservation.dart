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
import 'package:ac_mobile_final/schemas/customer.dart';
import 'package:ac_mobile_final/schemas/flight.dart';
import 'package:ac_mobile_final/schemas/reservation.dart';
import 'package:ac_mobile_final/pages/reservationOps/detail.dart';
import 'package:ac_mobile_final/pages/reservationOps/input.dart';

/// The main page to manage reservations.
///
/// Provides insert, update, and detail view of reservation records.
class ReservationPage extends StatefulWidget {
  /// Creates a [ReservationPage].
  const ReservationPage({
    super.key,
  });

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  /// UUID generator for customer IDs.
  final uuid = Uuid();
  /// Data source instance to interact with the backend.
  final DataSource _dataSource = DataSource.instance;

  // Controllers for insert.
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  /// List of all customer records.
  List<Customer> customers = [];
  /// List of all reservation records.
  List<Reservation> reservations = [];
  /// List of all flight records.
  List<Flight> flights = [];
  /// Currently selected reservation for detail.
  Reservation? selectedReservation;

  Customer? selectedCustomer;
  Flight? selectedFlight;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await _dataSource.syncAll();
      await AppCache.syncFromCustomerCache();

      flights = DataSource.flights;
      customers = DataSource.customers;

      setState(() {
        reservations = DataSource.reservations;

        if (AppCache.note != '') _noteController.text = AppCache.note;
        if (AppCache.flightDate != '') _dateController.text = AppCache.flightDate;
      });
    });
  }

  @override
  void dispose() {
    _noteController.dispose();
    _dateController.dispose();
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
        selectedReservation = null;
      });
    }

    /// Selects a reservation to show details.
    void selected(Reservation reservation) {
      setState(() {
        selectedReservation = reservation;
      });
    }

    /// Deletes a reservation.
    Future<void> removeReservation(Reservation? reservation) async {
      if (reservation == null) return;

      await _dataSource.deleteReservation(reservation);

      setState(() {
        reservations = DataSource.reservations;
      });
    }

    /// Inserts a new reservation based on the form inputs.
    Future<void> insertReservation() async {
      if (_noteController.text.trim().isEmpty) {
        SnackMessage.showMessage(context, localizations.msg2noNote, 1);
        return;
      }

      if (_dateController.text.trim().isEmpty) {
        SnackMessage.showMessage(context, localizations.msg2noFlightDate, 1);
        return;
      }

      if (selectedCustomer == null) {
        SnackMessage.showMessage(context, localizations.msg2noCustomer, 1);
        return;
      }

      if (selectedFlight == null) {
        SnackMessage.showMessage(context, localizations.msg2noFlight, 1);
        return;
      }

      await _dataSource.addReservation(
        Reservation(
          id: uuid.v1(),
          note: _noteController.text,
          customerId: selectedCustomer!.id,
          flightCode: selectedFlight!.id,
          flightDate: _dateController.text,
        ),
      );

      AppCache.note = _noteController.text;
      AppCache.flightDate = _dateController.text;

      await AppCache.syncToReservationCache();

      SnackMessage.showMessage(context, localizations.msg2addReservation, 2);

      setState(() {
        reservations = DataSource.reservations;
      });
    }

    /// Resets the reservation form and clears cached fields.
    Future<void> resetReservation() async {
      AppCache.note = '';
      AppCache.flightDate = '';
      await AppCache.syncToReservationCache();

      setState(() {
        _noteController.clear();
        _dateController.clear();
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
                    'assets/images/reservation_btn.png',
                    height: 150,
                    fit: BoxFit.cover,
                  )
              ),
              InputsBar(
                noteController: _noteController,
                dateController: _dateController,
                flights: flights,
                customers: customers,
                selectedCustomer: selectedCustomer,
                selectedFlight: selectedFlight,
                onClick: insertReservation,
                onReset: resetReservation,
                onCustomerChanged: (Customer? value) {
                  setState(() {
                    selectedCustomer = value;
                  });
                },
                onFlightChanged: (Flight? value) {
                  setState(() {
                    selectedFlight = value;
                  });
                },
              ),
              ...reservations.asMap().entries.map((entry) => Container(
                margin: EdgeInsets.all(10.0),
                child: Card(
                  elevation: 0.5,
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    title: Text(
                      entry.value.note,
                      style: GoogleFonts.roboto(),
                    ),
                    subtitle: Text(
                      '${entry.value.flightCode} ${entry.value.flightDate}',
                      style: GoogleFonts.roboto(),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReservationDetail(
                                reservation: entry.value,
                                flights: flights,
                                customers: customers,
                                onCancel: unselect,
                                onRemove: () => removeReservation(entry.value),
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
                        'assets/images/reservation_btn.png',
                        height: 150,
                        fit: BoxFit.cover,
                      )
                  ),
                  InputsBar(
                    noteController: _noteController,
                    dateController: _dateController,
                    flights: flights,
                    customers: customers,
                    selectedCustomer: selectedCustomer,
                    selectedFlight: selectedFlight,
                    onClick: insertReservation,
                    onReset: resetReservation,
                    onCustomerChanged: (Customer? value) {
                      setState(() {
                        selectedCustomer = value;
                      });
                    },
                    onFlightChanged: (Flight? value) {
                      setState(() {
                        selectedFlight = value;
                      });
                    },
                  ),
                  ...reservations.asMap().entries.map((entry) => Container(
                    margin: EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 0.5,
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        title: Text(
                          entry.value.note,
                          style: GoogleFonts.roboto(),
                        ),
                        subtitle: Text(
                          '${entry.value.flightCode} ${entry.value.flightDate}',
                          style: GoogleFonts.roboto(),
                        ),
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
            child: ReservationDetail(
              reservation: selectedReservation,
              flights: flights,
              customers: customers,
              onCancel: unselect,
              onRemove: () => removeReservation(selectedReservation),
              navBar: false,
              goBack: false,
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: MainNav(
        title: localizations.btn2reservation,
        returnButton: true,
      ),
      body: tabletLayout ? landscapeView : portraitView,
    );
  }
}