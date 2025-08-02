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
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A widget that displays input fields for creating a new airplane entry.
///
/// Includes fields for model, capacity, max speed, and range,
/// along with Add and Clear buttons at the bottom.
class InputsBar extends StatelessWidget {
  /// Called when the "Add" button is pressed.
  final VoidCallback onClick;

  /// Called when the "Clear" button is pressed.
  final VoidCallback onReset;

  /// Controller for the airplane model input field.
  final TextEditingController modelController;

  /// Controller for the airplane capacity input field.
  final TextEditingController capacityController;

  /// Controller for the max speed input field.
  final TextEditingController speedController;

  /// Controller for the range input field.
  final TextEditingController rangeController;

  /// Creates an [InputsBar] widget.
  ///
  /// All controllers and callbacks are required.
  const InputsBar({
    super.key,
    required this.modelController,
    required this.capacityController,
    required this.speedController,
    required this.rangeController,
    required this.onClick,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final modelInput = Container(
      margin: const EdgeInsets.all(10.0),
      child: TextField(
        controller: modelController,
        decoration: InputDecoration(
          labelText: localizations.label2model,
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

    final capacityInput = Container(
      margin: const EdgeInsets.all(10.0),
      child: TextField(
        controller: capacityController,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          labelText: localizations.label2capacity,
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

    final speedInput = Container(
      margin: const EdgeInsets.all(10.0),
      child: TextField(
        controller: speedController,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          labelText: localizations.label2speed,
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

    final rangeInput = Container(
      margin: const EdgeInsets.all(10.0),
      child: TextField(
        controller: rangeController,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          labelText: localizations.label2range,
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
          modelInput,
          capacityInput,
          speedInput,
          rangeInput,
          buttonsRow,
        ],
      ),
    );
  }
}
