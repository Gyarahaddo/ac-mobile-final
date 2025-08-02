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

/// A widget that displays input fields for creating or editing flight data.
///
/// Includes fields for flight code, cities, departure and arrival times,
/// and the assigned airplane model. Also features Add and Clear buttons.
class InputsBar extends StatelessWidget {
  /// Called when the "Add" button is pressed.
  final VoidCallback onClick;

  /// Called when the "Clear" button is pressed.
  final VoidCallback onReset;

  /// Controller for the flight code input field.
  final TextEditingController flightCodeController;

  /// Controller for the "From City" input field.
  final TextEditingController fromCityController;

  /// Controller for the "To City" input field.
  final TextEditingController toCityController;

  /// Controller for the departure time input field.
  final TextEditingController departureTimeController;

  /// Controller for the arrival time input field.
  final TextEditingController arrivalTimeController;

  /// Controller for the assigned airplane model input field.
  final TextEditingController assignedModelController;

  /// Creates an [InputsBar] widget for flight data input.
  ///
  /// All controllers and callbacks are required.
  const InputsBar({
    super.key,
    required this.flightCodeController,
    required this.fromCityController,
    required this.toCityController,
    required this.departureTimeController,
    required this.arrivalTimeController,
    required this.assignedModelController,
    required this.onClick,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final flightCodeInput = Container(
      margin: const EdgeInsets.all(10.0),
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
      margin: const EdgeInsets.all(10.0),
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

    final buttonsRow = Container(
      margin: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: onClick,
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.teal.shade50,
                foregroundColor: Colors.teal,
                side: const BorderSide(color: Colors.teal),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              ),
              child: Text(
                localizations.btn2add,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: OutlinedButton(
              onPressed: onReset,
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.red.shade50,
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              ),
              child: Text(
                localizations.btn2clear,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          vertical: 10.0
      ).copyWith(bottom: 16.0),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.outline,
                width: 1,
              )
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          flightCodeInput,
          fromCityInput,
          toCityInput,
          departureTimeInput,
          arrivalTimeInput,
          assignedModelInput,
          buttonsRow,
        ],
      ),
    );
  }
}
