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

class CustomerDetail extends StatelessWidget {
  final Customer? customer;
  final VoidCallback onRemove;
  final VoidCallback onCancel;
  final bool navBar;
  final bool goBack;

  const CustomerDetail({
    super.key,
    this.customer,
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
    final bool noCustomer = customer == null;

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
            buildDetailRow(localizations.label2firstname, noCustomer ? "Null" : customer!.firstname, textTheme),
            buildDetailRow(localizations.label2lastname, noCustomer ? "Null" : customer!.lastname, textTheme),
            buildDetailRow(localizations.label2address, noCustomer ? "Null" : customer!.address, textTheme),
            buildDetailRow(localizations.label2birthday, noCustomer ? "Null" : customer!.birthday, textTheme),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    onRemove();
                    onCancel();
                    Navigator.pop(context);
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
      appBar: navBar ? MainNav(title: 'Customer', returnButton: true,) : null,
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: noCustomer ? emptyCard : dataCard,
        ),
      ),
    );
  }
}