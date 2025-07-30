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
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ac_mobile_final/pages/home.dart';
import 'package:ac_mobile_final/services/datasource.dart';
import 'package:ac_mobile_final/services/appcache.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:google_fonts/google_fonts.dart';

/// The main entry point of the application.
///
/// Initializes Flutter bindings and runs the root widget [MyApp].
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DataSource.init();
  await EncryptedSharedPreferences.initialize('1234567890abcdef');
  await AppCache.init();

  runApp(const MyApp());
}

/// Root widget of the application.
///
/// This widget sets up state management, localization, and theme configuration.
/// It uses [MyAppState] as its state and provides a static [of] method to
/// access it from other widgets.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();

  /// Returns the current [MyAppState] from the widget tree.
  ///
  /// Useful for accessing methods like [setLocale] from child widgets.
  static MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>();
}

/// State class for [MyApp].
///
/// Manages the application's current locale and provides access
/// to change the locale dynamically using [setLocale].
class MyAppState extends State<MyApp> {
  /// The currently selected locale.
  Locale _locale = const Locale('en');

  /// Changes the application's locale.
  ///
  /// This triggers a rebuild and updates localization to the [newLocale].
  void setLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,

      supportedLocales: const [
        Locale('en'),
        Locale('fr')
      ],

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
