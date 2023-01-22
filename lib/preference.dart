import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waqoodi_client/constrants/colors.dart';
import 'package:waqoodi_client/ui/functions/customs/custom_loader_animation.dart';

class Preferences {
  static late SharedPreferences sharedPreferences;

  static initSharedPref() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    EasyLoading.instance
      ..loadingStyle =
          EasyLoadingStyle.custom //This was missing in earlier code
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.white
      ..indicatorColor = AppColors().primaryColor
      ..indicatorColor = AppColors().primaryColor
      ..maskColor = Colors.black26
      ..textColor = Colors.black
      ..userInteractions = true
      ..textStyle = GoogleFonts.poppins(
          fontSize: 14.0,
          color: Colors.black,
          fontWeight: FontWeight.w500)
      ..maskType = EasyLoadingMaskType.custom
      ..indicatorType = EasyLoadingIndicatorType.squareCircle
      ..animationStyle = EasyLoadingAnimationStyle.scale
      ..boxShadow = [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          offset: Offset(0, 1.0),
          blurRadius: 2.0,
        ),
      ]
      ..dismissOnTap = false;
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
