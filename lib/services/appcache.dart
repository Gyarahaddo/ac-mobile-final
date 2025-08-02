/// CST2335 Final Project.
///
/// Created: July 25, 2025
/// Group Members:
///  - Lingfeng "Galahad" Zhao (zhao0291@algonquinlive.com)
///  - Jesse Proulx (prou0212@algonquinlive.com)
///  - Xinghan Xu (xu000334@algonquinlive.com)
///  - Luca Barbesin (barb0285@algonquinlive.com)
library;

import 'package:encrypt_shared_preferences/provider.dart';

/// A singleton utility class that manages cached form field values
/// for Customer, Airplane, Flight, and Reservation pages.
///
/// Uses [EncryptedSharedPreferences] for persistence between sessions.
class AppCache {
  /// Internal singleton instance.
  static final AppCache _instance = AppCache._internal();

  /// Shared preferences handler for encrypted storage.
  static late EncryptedSharedPreferences _enPreferences;

  // --------------------------
  // Customer Page Cache Fields
  // --------------------------

  /// Cached first name from the Customer form.
  static String firstname = '';

  /// Cached last name from the Customer form.
  static String lastname = '';

  /// Cached address from the Customer form.
  static String address = '';

  /// Cached birthday from the Customer form.
  static String birthday = '';

  // --------------------------
  // Airplane Page Cache Fields
  // --------------------------

  /// Cached airplane model.
  static String model = '';

  /// Cached airplane capacity.
  static int capacity = 0;

  /// Cached airplane speed.
  static int speed = 0;

  /// Cached airplane range.
  static int range = 0;

  // --------------------------
  // Flight Page Cache Fields
  // --------------------------

  /// Cached flight code.
  static String flightCode = '';

  /// Cached departure city.
  static String fromCity = '';

  /// Cached arrival city.
  static String toCity = '';

  /// Cached departure time.
  static String departureTime = '';

  /// Cached arrival time.
  static String arrivalTime = '';

  /// Cached assigned airplane model.
  static String assignedModel = '';

  // --------------------------
  // Reservation Page Cache Fields
  // --------------------------

  /// Cached reservation note.
  static String note = '';

  /// Cached reservation flight date.
  static String flightDate = '';

  /// Private constructor for singleton pattern.
  AppCache._internal();

  /// Returns the singleton [AppCache] instance.
  static AppCache get instance => _instance;

  /// Initializes encrypted shared preferences.
  static Future<void> init() async {
    _enPreferences = EncryptedSharedPreferences.getInstance();
  }

  /// Saves customer-related cache values to shared preferences.
  static Future<void> syncToCustomerCache() async {
    await _enPreferences.setString('cFirstname', firstname);
    await _enPreferences.setString('cLastname', lastname);
    await _enPreferences.setString('cAddress', address);
    await _enPreferences.setString('cBirthday', birthday);
  }

  /// Loads customer-related cache values from shared preferences.
  static Future<void> syncFromCustomerCache() async {
    firstname = _enPreferences.getString('cFirstname') ?? '';
    lastname = _enPreferences.getString('cLastname') ?? '';
    address = _enPreferences.getString('cAddress') ?? '';
    birthday = _enPreferences.getString('cBirthday') ?? '';
  }

  /// Saves airplane-related cache values to shared preferences.
  static Future<void> syncToAirplaneCache() async {
    await _enPreferences.setString('aModel', model);
    await _enPreferences.setInt('aCapacity', capacity);
    await _enPreferences.setInt('aSpeed', speed);
    await _enPreferences.setInt('aRange', range);
  }

  /// Loads airplane-related cache values from shared preferences.
  static Future<void> syncFromAirplaneCache() async {
    model = _enPreferences.getString('aModel') ?? '';
    capacity = _enPreferences.getInt('aCapacity') ?? 0;
    speed = _enPreferences.getInt('aSpeed') ?? 0;
    range = _enPreferences.getInt('aRange') ?? 0;
  }

  /// Saves flight-related cache values to shared preferences.
  static Future<void> syncToFlightCache() async {
    await _enPreferences.setString('fCode', flightCode);
    await _enPreferences.setString('fFromCity', fromCity);
    await _enPreferences.setString('fToCity', toCity);
    await _enPreferences.setString('fDepartureTime', departureTime);
    await _enPreferences.setString('fArrivalTime', arrivalTime);
    await _enPreferences.setString('fModel', assignedModel);
  }

  /// Loads flight-related cache values from shared preferences.
  static Future<void> syncFromFlightCache() async {
    flightCode = _enPreferences.getString('fCode') ?? '';
    fromCity = _enPreferences.getString('fFromCity') ?? '';
    toCity = _enPreferences.getString('fToCity') ?? '';
    departureTime = _enPreferences.getString('fDepartureTime') ?? '';
    arrivalTime = _enPreferences.getString('fArrivalTime') ?? '';
    assignedModel = _enPreferences.getString('fModel') ?? '';
  }

  /// Saves reservation-related cache values to shared preferences.
  static Future<void> syncToReservationCache() async {
    await _enPreferences.setString('rNote', note);
    await _enPreferences.setString('rFlightDate', flightDate);
  }

  /// Loads reservation-related cache values from shared preferences.
  static Future<void> syncFromReservationCache() async {
    note = _enPreferences.getString('rNote') ?? '';
    flightDate = _enPreferences.getString('rFlightDate') ?? '';
  }
}
