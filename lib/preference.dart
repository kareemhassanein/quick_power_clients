

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Quick_Power/constrants/colors.dart';
import 'package:shimmer/shimmer.dart';

class Preferences {
  static late SharedPreferences sharedPreferences;
  static late CancelToken cancellationToken;


  static initSharedPref() async {
    WidgetsFlutterBinding.ensureInitialized();
    sharedPreferences = await SharedPreferences.getInstance();
    cancellationToken = CancelToken();
  }

  void loaderInstance(AdaptiveThemeMode? adaptiveThemeMode) {
    EasyLoading.init();
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = AppColors().primaryColor
      ..backgroundColor = adaptiveThemeMode == AdaptiveThemeMode.light
          ? Colors.white
          : Colors.black54
      ..boxShadow = [
        const BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 3)
      ]
      ..indicatorColor = AppColors().primaryColor
      ..maskColor = Colors.black26
      ..textColor = adaptiveThemeMode == AdaptiveThemeMode.light
          ? Colors.black
          : Colors.white
      ..userInteractions = true
      ..textStyle = GoogleFonts.alexandria(
        fontSize: 14.0,
        height: 2,
        fontWeight: FontWeight.w500,
      )
      ..errorWidget = const Icon(Icons.error_outline_rounded)
      ..indicatorWidget = const LogoRotatingIndicatorWidget()
      ..boxShadow = []
      ..dismissOnTap = false;
  }

  static Future<bool> setUserToken(String token) async {
    return sharedPreferences.setString('userToken', token);
  }

  static String? getUserToken() {
    return sharedPreferences.getString('userToken');
  }

  static Future<bool> removeUserData() async {
    await FirebaseMessaging.instance.deleteToken();
    return await sharedPreferences.remove('userToken');
  }
}

class LogoRotatingIndicatorWidget extends StatelessWidget {
  const LogoRotatingIndicatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lightBaseColor = Colors.grey[300]!;
    final lightHighlightColor = AppColors().primaryColor;
    final darkBaseColor = Colors.grey[700]!;
    final darkHighlightColor = AppColors().primaryColor;

    return Shimmer.fromColors(
      baseColor: Theme.of(context).brightness == Brightness.light
          ? lightBaseColor
          : darkBaseColor,
      highlightColor: Theme.of(context).brightness == Brightness.light
          ? lightHighlightColor
          : darkHighlightColor,
      child: SizedBox(
        width: 70,
        height: 70,
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}