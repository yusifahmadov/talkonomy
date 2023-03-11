import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../features/user/data/models/user_response_model.dart';

class AppSharedPreferences {
  static saveUser(String key, UserResponseModel value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, json.encode(value).toString());
  }

  static readUser(String key) async {
    final prefs = await SharedPreferences.getInstance();
    //json.decode to convert json string back to Json Object
    if (prefs.getString(key) != null) {
      return json.decode(prefs.getString(key)!);
    }
  }
}
