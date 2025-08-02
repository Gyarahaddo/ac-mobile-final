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
import 'package:ac_mobile_final/components/navbar.dart';
import 'package:ac_mobile_final/components/commons.dart';
import 'package:ac_mobile_final/schemas/airplane.dart';

/// A widget that displays input fields for updating an existing [Airplane] object.
///
/// Allows editing airplane model, capacity, speed, and range.
/// Typically used in the airplane update workflow.
class UpdateAirplane extends StatelessWidget {
  /// Callback triggered when the update is confirmed.
  final VoidCallback onUpdate;

  /// The original [Airplane] object to be updated.
  final Airplane airplane;

  /// Controller for the airplane model input field.
  final TextEditingController modelController;

  /// Controller for the airplane capacity input field.
  final TextEditingController capacityController;

  /// Controller for the airplane max speed input field.
  final TextEditingController speedController;

  /// Controller for the airplane range input field.
  final TextEditingController rangeController;

  /// Creates an [UpdateAirplane] widget.
  ///
  /// All input controllers, the target [airplane], and the [onUpdate] callback are required.
  const UpdateAirplane({
    super.key,
    required this.onUpdate,
    required this.airplane,
    required this.modelController,
    required this.capacityController,
    required this.speedController,
    required this.rangeController,
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
            buildDetailRow(localizations.label2model, airplane.model, textTheme),
            buildDetailRow(localizations.label2capacity, airplane.capacity.toString(), textTheme),
            buildDetailRow(localizations.label2speed, '${airplane.maxSpeed} KM/s', textTheme),
            buildDetailRow(localizations.label2range, '${airplane.range} KMs', textTheme),
          ],
        ),
      ),
    );

    final modelInput = Container(
      margin: const EdgeInsets.all(5.0),
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
                    modelInput,
                    capacityInput,
                    speedInput,
                    rangeInput,
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