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
import 'package:ac_mobile_final/schemas/customer.dart';

class UpdateCustomer extends StatelessWidget {
  final VoidCallback onUpdate;
  final Customer customer;
  final TextEditingController firstnameController;
  final TextEditingController lastnameController;
  final TextEditingController addressController;
  final TextEditingController birthdayController;

  const UpdateCustomer({
    super.key,
    required this.onUpdate,
    required this.customer,
    required this.firstnameController,
    required this.lastnameController,
    required this.addressController,
    required this.birthdayController,
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
            buildDetailRow(localizations.label2firstname, customer.firstname, textTheme),
            buildDetailRow(localizations.label2lastname, customer.lastname, textTheme),
            buildDetailRow(localizations.label2address, customer.address, textTheme),
            buildDetailRow(localizations.label2birthday, customer.birthday, textTheme),
          ],
        ),
      ),
    );

    final firstnameInput = Container(
      margin: const EdgeInsets.all(5.0),
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
      margin: const EdgeInsets.all(5.0),
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
      margin: const EdgeInsets.all(5.0),
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
      margin: const EdgeInsets.all(5.0),
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
                    firstnameInput,
                    lastnameInput,
                    addressInput,
                    birthdayInput,
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