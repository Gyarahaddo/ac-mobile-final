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

/// A widget that displays flight update input fields and summary.
///
/// Shows original flight details, allows editing the fields,
/// and provides confirm and discard actions.
class UpdateFlight extends StatelessWidget {
  /// Callback triggered when the user confirms the update.
  final VoidCallback onUpdate;

  /// The original [Flight] object being updated.
  final Flight flight;

  /// Controller for flight code input.
  final TextEditingController flightCodeController;

  /// Controller for departure city input.
  final TextEditingController fromCityController;

  /// Controller for destination city input.
  final TextEditingController toCityController;

  /// Controller for departure time input.
  final TextEditingController departureTimeController;

  /// Controller for arrival time input.
  final TextEditingController arrivalTimeController;

  /// Controller for the assigned airplane model.
  final TextEditingController assignedModelController;

  /// Creates an [UpdateFlight] widget.
  ///
  /// All controllers and the original [flight] object are required.
  const UpdateFlight({
    super.key,
    required this.onUpdate,
    required this.flight,
    required this.flightCodeController,
    required this.fromCityController,
    required this.toCityController,
    required this.departureTimeController,
    required this.arrivalTimeController,
    required this.assignedModelController,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool tabletLayout = screenWidth > 600;

    final localizations = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

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
            buildDetailRow(localizations.label2flightCode, flight.flightCode, textTheme),
            buildDetailRow(localizations.label2fromCity, flight.fromCity, textTheme),
            buildDetailRow(localizations.label2toCity, flight.toCity, textTheme),
            buildDetailRow(localizations.label2departureTime, flight.departureTime, textTheme),
            buildDetailRow(localizations.label2arrivalTime, flight.arrivalTime, textTheme),
            buildDetailRow(localizations.label2assignedModel, flight.model, textTheme),
          ],
        ),
      ),
    );

    final flightCodeInput = Container(
      margin: const EdgeInsets.all(5.0),
      child: TextField(
        controller: flightCodeController,
        decoration: InputDecoration(
          labelText: localizations.label2flightCode,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );

    final fromCityInput = Container(
      margin: const EdgeInsets.all(5.0),
      child: TextField(
        controller: fromCityController,
        decoration: InputDecoration(
          labelText: localizations.label2fromCity,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );

    final toCityInput = Container(
      margin: const EdgeInsets.all(10.0),
      child: TextField(
        controller: toCityController,
        decoration: InputDecoration(
          labelText: localizations.label2toCity,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );

    final departureTimeInput = Container(
      margin: const EdgeInsets.all(10.0),
      child: TextField(
        controller: departureTimeController,
        readOnly: true, // Prevent keyboard input
        onTap: () async {
          final pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );

          if (pickedTime != null) {
            final formattedTime = pickedTime.format(context); // Returns locale-based format
            // Format to always 24h "HH:MM"
            final timeString = pickedTime.hour.toString().padLeft(2, '0') +
                ":" +
                pickedTime.minute.toString().padLeft(2, '0');

            departureTimeController.text = timeString;
          }
        },
        decoration: InputDecoration(
          labelText: localizations.label2departureTime,
          hintText: 'HH:MM',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          suffixIcon: const Icon(Icons.access_time),
        ),
      ),
    );

    final arrivalTimeInput = Container(
      margin: const EdgeInsets.all(10.0),
      child: TextField(
        controller: arrivalTimeController,
        readOnly: true, // Prevent keyboard input
        onTap: () async {
          final pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );

          if (pickedTime != null) {
            final formattedTime = pickedTime.format(context); // Returns locale-based format
            // Format to always 24h "HH:MM"
            final timeString = pickedTime.hour.toString().padLeft(2, '0') +
                ":" +
                pickedTime.minute.toString().padLeft(2, '0');

            arrivalTimeController.text = timeString;
          }
        },
        decoration: InputDecoration(
          labelText: localizations.label2arrivalTime,
          hintText: 'HH:MM',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          suffixIcon: const Icon(Icons.access_time),
        ),
      ),
    );

    final assignedModelInput = Container(
      margin: const EdgeInsets.all(10.0),
      child: TextField(
        controller: assignedModelController,
        decoration: InputDecoration(
          labelText: localizations.label2assignedModel,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: MainNav(
        title: localizations.text2update,
        returnButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: tabletLayout ? 20.0 : 5.0,
                ).copyWith(bottom: 16.0),
                child: Column(
                  children: [
                    dataCard,
                    flightCodeInput,
                    fromCityInput,
                    toCityInput,
                    departureTimeInput,
                    arrivalTimeInput,
                    assignedModelInput,
                    const SizedBox(width: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            onUpdate();
                            Navigator.of(context).pop();
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Theme.of(context).colorScheme.error,
                            side: BorderSide(color: Theme.of(context).colorScheme.error),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(localizations.btn2Confirm),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Theme.of(context).colorScheme.primary,
                            side: BorderSide(color: Theme.of(context).colorScheme.outline),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(localizations.btn2Discard),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}