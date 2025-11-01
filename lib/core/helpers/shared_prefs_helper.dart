import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const String _registrationKey = 'registration_token';
  static const String _rememberMeKey = 'remember_me';

  Future<void> saveRegistrationToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_registrationKey, token);
  }

  Future<String?> getRegistrationToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_registrationKey);
  }

  Future<void> clearRegistrationToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_registrationKey);
  }

  Future<void> saveRememberMe(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rememberMeKey, value);
  }

  Future<bool> getRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_rememberMeKey) ?? false;
  }

  Future<void> saveUserId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("user_id", id);
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt("user_id");
  }

}