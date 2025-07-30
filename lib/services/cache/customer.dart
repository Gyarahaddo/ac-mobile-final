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

class CustomerCache {
  static final CustomerCache _instance = CustomerCache._internal();

  static late EncryptedSharedPreferences _enPreferences;
  static String firstname = '';
  static String lastname = '';
  static String address = '';
  static String birthday = '';

  CustomerCache._internal();

  static CustomerCache get instance => _instance;

  static Future<void> init() async {
    _enPreferences = EncryptedSharedPreferences.getInstance();
  }

  static Future<void> syncToCustomerCache() async {
    await _enPreferences.setString('cFirstname', firstname);
    await _enPreferences.setString('cLastname', lastname);
    await _enPreferences.setString('cAddress', address);
    await _enPreferences.setString('cBirthday', birthday);
    print('DEBUG::Customer Cache -> Sync to Preferences');
  }

  static Future<void> syncFromCustomerCache() async {
    firstname = _enPreferences.getString('cFirstname') ?? '';
    lastname = _enPreferences.getString('cLastname') ?? '';
    address = _enPreferences.getString('cAddress') ?? '';
    birthday = _enPreferences.getString('cBirthday') ?? '';
    print('DEBUG::Customer Cache -> Sync From Preferences');
  }
}