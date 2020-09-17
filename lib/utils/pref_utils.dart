import 'dart:convert';

import 'package:bidders/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

// ignore: avoid_classes_with_only_static_members
class PrefUtils {
  static SharedPreferences prefs;

  static Future<bool> init() async {
    prefs = await SharedPreferences.getInstance();
    return prefs != null;
  }

  static void setUserToken(String token) {
    prefs.setString(SharedPrefsKeys.USER_TOKEN, token);
  }

  static String getUserToken() {
    final String value = prefs.getString(SharedPrefsKeys.USER_TOKEN);
    return value;
  }

  static void setUser(AppUser user) {
    prefs.setString(KPrefs.USER_DATA, json.encode(user));
  }
}
