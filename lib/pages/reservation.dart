import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ac_mobile_final/components/navbar.dart';

class ReservationPage extends StatefulWidget {

  const ReservationPage({
    super.key,
  });

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: MainNav(
        title: localizations.btn2reservation,
        returnButton: true,
      ),
      body: Scaffold(),
    );
  }
}