import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ac_mobile_final/components/navbar.dart';

class AirplanePage extends StatefulWidget {

  const AirplanePage({
    super.key,
  });

  @override
  State<AirplanePage> createState() => _AirplanePageState();
}

class _AirplanePageState extends State<AirplanePage> {
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
        title: localizations.btn2airplane,
        returnButton: true,
      ),
      body: Scaffold(),
    );
  }
}