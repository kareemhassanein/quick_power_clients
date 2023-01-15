import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences sharedPreferences;

  static initSharedPref() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    sharedPreferences = await SharedPreferences.getInstance();
  }


  static Future<bool> setUserToken(String token) async {
    return sharedPreferences.setString('userToken', token);
  }


  static String? getUserToken() {
    return sharedPreferences.getString('userToken');
  }

  static Future<bool> removeUserData() async {
    return await sharedPreferences.remove('userToken');
  }
}
