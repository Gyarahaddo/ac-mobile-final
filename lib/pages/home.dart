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
import 'package:ac_mobile_final/components/footer.dart';
import 'package:ac_mobile_final/components/button.dart';
import 'package:ac_mobile_final/pages/customer.dart';
import 'package:ac_mobile_final/pages/airplane.dart';
import 'package:ac_mobile_final/pages/flights.dart';
import 'package:ac_mobile_final/pages/reservation.dart';

/// The main landing page of the app that provides navigation to
/// different modules: Customers, Airplanes, Flights, and Reservations.
///
/// The layout adapts based on screen width (mobile vs. tablet).
class HomePage extends StatefulWidget {
  /// Creates the [HomePage] widget.
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

/// State class for [HomePage].
class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {});
  }

  @override
  Widget build(BuildContext context) {
    // Determine screen width to adjust layout
    double screenWidth = MediaQuery.of(context).size.width;
    bool tabletLayout = screenWidth > 600;

    // Load localization
    final localizations = AppLocalizations.of(context)!;

    // Define navigation buttons
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
        nextPage: FlightPage(),
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
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          child: tabletLayout ?
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        navButtons[0],
                        navButtons[1],
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        navButtons[2],
                        navButtons[3],
                      ],
                    ),
                  ),
                ],
              ),
              CopyrightFooter(content: localizations.copyright),
            ],
          ):
          Column(
            children: [
              ...navButtons,
              CopyrightFooter(content: localizations.copyright),
            ],
          )
        ),
      ),
    );
  }
}
