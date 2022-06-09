import 'package:shared_preferences/shared_preferences.dart';

class UserDriverPreferences {
  static const _keyUserEmail = 'UserEmail';
  static Future setUserEmail(String userEmail) async {
    final prefernces = await SharedPreferences.getInstance();
    await prefernces.setString(_keyUserEmail, userEmail);
  }

  static Future getUserEmail() async {
    final prefernces = await SharedPreferences.getInstance();
    prefernces.getString(_keyUserEmail);
  }

  static const _keyDriverEmail = 'DriverEmail';
  static Future setDriverEmail(String driverEmail) async {
    final prefernces = await SharedPreferences.getInstance();
    await prefernces.setString(_keyDriverEmail, driverEmail);
  }

  static Future getDriverEmail() async {
    final prefernces = await SharedPreferences.getInstance();
    prefernces.getString(_keyUserEmail);
  }
}
