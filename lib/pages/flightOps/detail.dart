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
import 'package:ac_mobile_final/schemas/flight.dart';

/// A widget that displays detailed information about a [Flight].
///
/// Allows the user to view, remove, or cancel flight details.
/// Optionally shows a navigation bar and can navigate back on action.
class FlightDetail extends StatelessWidget {
  /// The flight object to display.
  final Flight? flight;

  /// Callback triggered when the remove button is pressed.
  final VoidCallback onRemove;

  /// Callback triggered when the cancel button is pressed.
  final VoidCallback onCancel;

  /// Whether to show the top navigation bar.
  final bool navBar;

  /// Whether to navigate back after an action.
  final bool goBack;

  /// Creates a [FlightDetail] widget.
  ///
  /// [onRemove], [onCancel], [navBar], and [goBack] are required.
  const FlightDetail({
    super.key,
    this.flight,
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
    final bool noFlight = flight == null;

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
            buildDetailRow(localizations.label2flightCode, noFlight ? "Null" : flight!.flightCode, textTheme),
            buildDetailRow(localizations.label2fromCity, noFlight ? "Null" : flight!.fromCity, textTheme),
            buildDetailRow(localizations.label2toCity, noFlight ? "Null" : flight!.toCity, textTheme),
            buildDetailRow(localizations.label2departureTime, noFlight ? "Null" : flight!.departureTime, textTheme),
            buildDetailRow(localizations.label2arrivalTime, noFlight ? "Null" : flight!.arrivalTime, textTheme),
            buildDetailRow(localizations.label2assignedModel, noFlight ? "Null" : flight!.model, textTheme),
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
      appBar: navBar ? MainNav(title: 'Flight', returnButton: true,) : null,
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: noFlight ? emptyCard : dataCard,
        ),
      ),
    );
  }
}