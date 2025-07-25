import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ac_mobile_final/components/navbar.dart';
import 'package:ac_mobile_final/components/footer.dart';
import 'package:ac_mobile_final/components/button.dart';
import 'package:ac_mobile_final/pages/customer.dart';
import 'package:ac_mobile_final/pages/airplane.dart';
import 'package:ac_mobile_final/pages/flights.dart';
import 'package:ac_mobile_final/pages/reservation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool tabletLayout = screenWidth > 600;

    final localizations = AppLocalizations.of(context)!;

    final navButtons = [
      NavButton(
        btnText: localizations.btn2customer,
        btnImagePath: 'assets/images/customer_btn.png',
        nextPage: CustomerPage(),
      ),
      NavButton(
        btnText: localizations.btn2airplane,
        btnImagePath: 'assets/images/airplane_btn.png',
        nextPage: AirplanePage(),
      ),
      NavButton(
        btnText: localizations.btn2flight,
        btnImagePath: 'assets/images/flight_btn.png',
        nextPage: FlightsPage(),
      ),
      NavButton(
        btnText: localizations.btn2reservation,
        btnImagePath: 'assets/images/reservation_btn.png',
        nextPage: ReservationPage(),
      ),
    ];

    return Scaffold(
      appBar: MainNav(
        title: 'GroupProject_S25',
        returnButton: false,
      ),
      drawer: tabletLayout ?
        Drawer(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: navButtons,
          ),
        ) : null,
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...navButtons,
              CopyrightFooter(content: localizations.copyright),
            ],
          ),
        ),
      ),
    );
  }
}
