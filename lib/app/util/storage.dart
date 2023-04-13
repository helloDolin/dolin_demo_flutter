import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Future<void> setData(String key, dynamic value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, json.encode(value));
  }

  static Future<String> getData(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? data = pref.getString(key);
    return json.decode(data ?? '');
  }

  static removeData(String key) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.remove(key);
    } catch (e) {
      print('removeData 异常 $e');
    }
  }
}
