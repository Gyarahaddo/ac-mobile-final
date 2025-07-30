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

class InputsBar extends StatelessWidget {
  final VoidCallback onClick;
  final VoidCallback onReset;
  final TextEditingController firstnameController;
  final TextEditingController lastnameController;
  final TextEditingController addressController;
  final TextEditingController birthdayController;

  const InputsBar({
    super.key,
    required this.firstnameController,
    required this.lastnameController,
    required this.addressController,
    required this.birthdayController,
    required this.onClick,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final firstnameInput = Container(
      margin: const EdgeInsets.all(10.0),
      child: TextField(
        controller: firstnameController,
        decoration: InputDecoration(
          labelText: localizations.label2firstname,
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

    final lastnameInput = Container(
      margin: const EdgeInsets.all(10.0),
      child: TextField(
        controller: lastnameController,
        decoration: InputDecoration(
          labelText: localizations.label2lastname,
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

    final addressInput = Container(
      margin: const EdgeInsets.all(10.0),
      child: TextField(
        controller: addressController,
        decoration: InputDecoration(
          labelText: localizations.label2address,
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

    final birthdayInput = Container(
      margin: const EdgeInsets.all(10.0),
      child: TextField(
        controller: birthdayController,
        readOnly: true, // For picker use
        onTap: () async {
          final pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime(2000),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null) {
            birthdayController.text =
            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
          }
        },
        decoration: InputDecoration(
          labelText: localizations.label2birthday,
          hintText: 'YYYY-MM-DD',
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
          suffixIcon: const Icon(Icons.calendar_today),
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
          firstnameInput,
          lastnameInput,
          addressInput,
          birthdayInput,
          buttonsRow,
        ],
      ),
    );
  }
}
