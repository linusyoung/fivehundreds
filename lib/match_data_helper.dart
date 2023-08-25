import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class MatchDataHelper {
  static Future<dynamic> getMatchInfo(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return json.decode(prefs.getString(key) as String) ?? null;
  }

  static Future<bool> setMatchInfo(String key, dynamic value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, json.encode(value));
  }

  static Future<List<Map<String, dynamic>>> getAllMatch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getKeys().map((key) {
      Map<String, dynamic> map = Map();
      map[key] = json.decode(prefs.getString(key) as String);
      return map;
    }).toList();
  }
}
