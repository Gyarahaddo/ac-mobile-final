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
import 'package:ac_mobile_final/components/navbar.dart';
import 'package:ac_mobile_final/components/commons.dart';
import 'package:ac_mobile_final/schemas/reservation.dart';
import 'package:ac_mobile_final/schemas/flight.dart';
import 'package:ac_mobile_final/schemas/customer.dart';

/// A widget that displays detailed information about a [Reservation].
///
/// Shows flight and customer details associated with the reservation.
/// Allows removing or canceling the view, and optionally shows a navigation bar.
class ReservationDetail extends StatelessWidget {
  /// The reservation object to display.
  final Reservation? reservation;

  /// List of all available flights for lookup.
  final List<Flight> flights;

  /// List of all customers for lookup.
  final List<Customer> customers;

  /// Callback triggered when the remove button is pressed.
  final VoidCallback onRemove;

  /// Callback triggered when the cancel button is pressed.
  final VoidCallback onCancel;

  /// Whether to show the top navigation bar.
  final bool navBar;

  /// Whether to navigate back after an action.
  final bool goBack;

  /// Creates a [ReservationDetail] widget.
  ///
  /// Requires [flights], [customers], [onRemove], [onCancel], [navBar], and [goBack].
  const ReservationDetail({
    super.key,
    this.reservation,
    required this.flights,
    required this.customers,
    required this.onRemove,
    required this.onCancel,
    required this.navBar,
    required this.goBack,
  });


  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    Flight? targetFlight = flights
        .cast<Flight?>()
        .firstWhere((flight) => flight?.id == reservation?.flightCode,
      orElse: () => null,
    );

    Customer? targetCustomer = customers
        .cast<Customer?>()
        .firstWhere((customer) => customer?.id == reservation?.customerId,
      orElse: () => null,
    );

    print('DEBUG:: targetCustomer-> ${targetCustomer.toString()}');
    print('DEBUG:: targetFlight-> ${targetFlight.toString()}');

    final bool noReservation = reservation == null;
    final bool noFlight = targetFlight == null;
    final bool noCustomer =  targetCustomer == null;

    final emptyCard = Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                localizations.text2noSelection,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            )
          ],
        ),
      ),
    );

    final dataCard = Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            buildDetailRow(localizations.label2note, noReservation ? "Null" : reservation!.note, textTheme),
            buildDetailRow(localizations.label2customerId, noCustomer ? "Missing" : '${targetCustomer.firstname} ${targetCustomer.lastname}', textTheme),
            buildDetailRow(localizations.label2flightCode , noFlight ? "No Flight" : targetFlight.flightCode, textTheme),
            buildDetailRow(localizations.label2assignedModel , noFlight ? "No Data" : targetFlight.model, textTheme),
            buildDetailRow(localizations.label2fromCity , noFlight ? "No Data" : targetFlight.fromCity, textTheme),
            buildDetailRow(localizations.label2toCity , noFlight ? "No Data" : targetFlight.toCity, textTheme),
            buildDetailRow(localizations.label2departureTime , noFlight ? "No Data" : targetFlight.departureTime, textTheme),
            buildDetailRow(localizations.label2arrivalTime , noFlight ? "No Data" : targetFlight.arrivalTime, textTheme),
            buildDetailRow(localizations.label2departureTime, noReservation ? "Null" : reservation!.flightDate, textTheme),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    onRemove();
                    onCancel();
                    if (goBack) Navigator.pop(context);
                  },
                  icon: Icon(Icons.delete),
                  label: Text(localizations.btn2Remove),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.error,
                    foregroundColor: colorScheme.onError,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    onCancel();
                    if (goBack) Navigator.pop(context);
                  },
                  icon: Icon(Icons.cancel),
                  label: Text(localizations.btn2Discard),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primaryContainer,
                    foregroundColor: colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: navBar ? MainNav(title: 'Reservation', returnButton: true,) : null,
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: noReservation ? emptyCard : dataCard,
        ),
      ),
    );
  }
}