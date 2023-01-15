import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waqoodi_client/preference.dart';
import 'package:waqoodi_client/ui/screens/login_screen.dart';
import 'package:waqoodi_client/ui/screens/splash_screen.dart';

import 'constrants/colors.dart';


Future<void> main() async {
  await Preferences.initSharedPref();

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        statusBarIconBrightness: Platform.isIOS ? Brightness.light : Brightness.dark,
      statusBarBrightness: Platform.isIOS ? Brightness.light : Brightness.dark,
      systemNavigationBarIconBrightness: Platform.isIOS ? Brightness.light : Brightness.dark,));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  SystemChrome.setApplicationSwitcherDescription(const ApplicationSwitcherDescription(primaryColor: 0xff39969B, label: 'Waqoodi'));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var s = 'Kareem';
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            accentColor: AppColors().primaryColor,
            fontFamily: GoogleFonts.poppins().fontFamily,
            primaryColor: AppColors().primaryColor,
            backgroundColor: AppColors().backgroundColor,
            splashColor: Colors.white,
            highlightColor: Colors.white.withOpacity(.5),
          ),
          home: child,
          builder: EasyLoading.init(),
        );
      },
      child: const SplashScreen(),
    );
  }

}
