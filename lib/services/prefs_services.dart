// ignore_for_file: prefer_const_declarations

import 'package:shared_preferences/shared_preferences.dart';

class PresService {
  final String _keyTheme = 'theme';

  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getBool(_keyTheme));
    return Future.value(prefs.getBool(_keyTheme) ?? false);
  }

  setTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_keyTheme, value);
  }
}