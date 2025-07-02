import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:ac_mobile_final/localization/languages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainPage(),
    );
  }
}

class HomeNav extends StatelessWidget implements PreferredSizeWidget {
  String title;
  VoidCallback changeLoc;

  HomeNav({
    super.key,
    required this.title,
    required this.changeLoc
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      centerTitle: true,
      title: Text(title),
      actions: [
        IconButton(
          onPressed: changeLoc,
          icon: Icon(Icons.translate),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MainPageLoc currentLoc = MainPageEN();

  void switchLoc() {
    setState(() {
      if (currentLoc.runtimeType.toString() == 'MainPageEN') {
        currentLoc = MainPageFR();
      }
      else {
        currentLoc = MainPageEN();
      }
      if (kDebugMode) {
        debugPrint(currentLoc.runtimeType.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: HomeNav(
        title: currentLoc.title,
        changeLoc: switchLoc,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(currentLoc.btnCustomer),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(currentLoc.btnAirplane),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(currentLoc.btnFlights),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(currentLoc.btnReservation),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    )
                  )
                ),
                child: Text(currentLoc.footer),
              )
            )
          ],
        ),
      )
    );
  }
}
