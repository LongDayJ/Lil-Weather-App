// ignore_for_file: prefer_const_declarations

import 'package:shared_preferences/shared_preferences.dart';

class PresService {
  static final String _keyTheme = "theme";

  static Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyTheme) ?? false;
  }

  setTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_keyTheme, value);
  }
}