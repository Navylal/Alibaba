import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static late SharedPreferences _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future saveTheme(bool isDark) async {
    await _prefs.setBool("theme_dark", isDark);
  }

  static bool getTheme() {
    return _prefs.getBool("theme_dark") ?? false;
  }

  static Future setLoggedIn(bool value) async {
    await _prefs.setBool("user_logged_in", value);
  }

  static bool isLoggedIn() {
    return _prefs.getBool("user_logged_in") ?? false;
  }

  static Future saveEmail(String email) async {
    await _prefs.setString("user_email", email);
  }

  static String? getEmail() {
    return _prefs.getString("user_email");
  }

  static Future saveRole(String role) async {
    await _prefs.setString("user_role", role);
    await setLoggedIn(true);
  }

  static String? getRole() {
    return _prefs.getString("user_role");
  }

  static Future saveLogin({
    required String username,
    required String role,
  }) async {
    await _prefs.setString("user_username", username);
    await _prefs.setString("user_role", role);
    await setLoggedIn(true);
  }

  static String? getUsername() {
    return _prefs.getString("user_username");
  }

  static Future logout() async {
    await _prefs.remove("user_username");
    await _prefs.remove("user_role");
    await _prefs.remove("user_email");
    await setLoggedIn(false);
  }
}
