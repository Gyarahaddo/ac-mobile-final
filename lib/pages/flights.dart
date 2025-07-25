import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ac_mobile_final/components/navbar.dart';

class FlightsPage extends StatefulWidget {

  const FlightsPage({
    super.key,
  });

  @override
  State<FlightsPage> createState() => _FlightsPageState();
}

class _FlightsPageState extends State<FlightsPage> {
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
        title: localizations.btn2flight,
        returnButton: true,
      ),
      body: Scaffold(),
    );
  }
}