import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static SharedPreferences? _prefs;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }

  //set methods
  static Future<bool> setBool(String key, bool value) async =>
      await _prefs!.setBool(key, value);

  static Future<bool> setString(String key, String value) async =>
      await _prefs!.setString(key, value);

  static Future<bool> setInt(String key, int value) async =>
      await _prefs!.setInt(key, value);

  static Future<bool> setDouble(String key, double value) async =>
      await _prefs!.setDouble(key, value);

  static Future<bool> setObject(String key, value) async {
    return await _prefs!.setString(key, json.encode(value));
  }

  //get methods
  static bool getBool(String key) {
    return (_prefs!.getBool(key) == null) ? false : _prefs!.getBool(key)!;
  }

  static String? getString(String key) {
    return _prefs!.getString(key)!;
  }

  static int getInt(String key) {
    return (_prefs!.getInt(key) == null) ? 0 : _prefs!.getInt(key)!;
  }

  static double getDouble(String key) {
    return (_prefs!.getDouble(key) == null) ? 0 : _prefs!.getDouble(key)!;
  }

  static getObject(String key) {
    return (_prefs!.getString(key) == null)
        ? null
        : json.decode(_prefs!.getString(key)!);
  }

  //deletes
  static Future<bool> remove(String key) async => await _prefs!.remove(key);

  static Future<bool> clear() async => await _prefs!.clear();
}
