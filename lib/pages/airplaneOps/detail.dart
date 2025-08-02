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
import 'package:ac_mobile_final/schemas/airplane.dart';

/// A widget that displays detailed information about an [Airplane].
///
/// Allows the user to view details, remove the record, or cancel the view.
/// Optional app bar and navigation control are supported.
class AirplaneDetail extends StatelessWidget {
  /// The airplane object to display.
  final Airplane? airplane;

  /// Callback triggered when the remove button is pressed.
  final VoidCallback onRemove;

  /// Callback triggered when the cancel button is pressed.
  final VoidCallback onCancel;

  /// Whether to show the top navigation bar.
  final bool navBar;

  /// Whether to navigate back after an action.
  final bool goBack;

  /// Creates an [AirplaneDetail] widget.
  ///
  /// [onRemove], [onCancel], [navBar], and [goBack] are required.
  const AirplaneDetail({
    super.key,
    this.airplane,
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
    final bool noAirplane = airplane == null;

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
            buildDetailRow(localizations.label2model, noAirplane ? "Null" : airplane!.model, textTheme),
            buildDetailRow(localizations.label2capacity, noAirplane ? "Null" : airplane!.capacity.toString(), textTheme),
            buildDetailRow(localizations.label2speed, noAirplane ? "Null" : '${airplane!.maxSpeed.toString()} KM/h', textTheme),
            buildDetailRow(localizations.label2range, noAirplane ? "Null" : '${airplane!.range.toString()} KMs', textTheme),
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
      appBar: navBar ? MainNav(title: 'Airplane', returnButton: true,) : null,
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: noAirplane ? emptyCard : dataCard,
        ),
      ),
    );
  }
}