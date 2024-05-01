import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static dynamic get(String key) {
    return _prefs.get(key);
  }

  static Future<bool> put(String key, dynamic value) async {
    if (value is String) {
      return await _prefs.setString(key, value);
    } else if (value is int) {
      return await _prefs.setInt(key, value);
    } else if (value is double) {
      return await _prefs.setDouble(key, value);
    } else if (value is bool) {
      return await _prefs.setBool(key, value);
    } else if (value is List<String>) {
      return await _prefs.setStringList(key, value);
    } else {
      final jsonString = json.encode(value);
      return await _prefs.setString(key, jsonString);
    }
  }

  static Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }
}
