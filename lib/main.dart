import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Quick_Power/preference.dart';
import 'package:Quick_Power/ui/screens/login_screen.dart';
import 'package:Quick_Power/ui/screens/splash_screen.dart';

import 'constrants/colors.dart';
import 'localization/AppLocalizationDelgate.dart';
import 'localization/LanguageHelper.dart';


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
  runApp(const StartApp());
}

class StartApp extends StatefulWidget {
  const StartApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_StartAppState>();
    state!.setLocale(newLocale);
  }
  @override
  _StartAppState createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> with WidgetsBindingObserver {
  late Locale _locale;

  @override
  void didChangeDependencies() async {
    LanguageHelper.getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
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
          locale: _locale,
          supportedLocales: supportedLocales,
          localizationsDelegates: localizationsDelegates,
          localeResolutionCallback: localeResolutionCallback,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: GoogleFonts.readexPro().fontFamily,
            primaryColor: AppColors().primaryColor,
            backgroundColor: AppColors().backgroundColor,
            splashColor: Colors.white.withOpacity(.3),
            highlightColor: Colors.white.withOpacity(.2),
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                overlayColor:MaterialStatePropertyAll(AppColors().primaryColor.withOpacity(0.1))
              )
            ),
            textSelectionTheme: TextSelectionThemeData(
              selectionHandleColor: AppColors().primaryColor,
              cursorColor: AppColors().primaryColor,
              selectionColor: AppColors().primaryColor.withOpacity(0.2)
            )
          ),
          home: child,
          builder: EasyLoading.init(),
        );
      },
      child: const SplashScreen(),
    );
  }
}

class Init {
  Init._();

  static final instance = Init._();

  Future initialize(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
  }
}
extension Localization on _StartAppState {
  Iterable<Locale> get supportedLocales => const [
    Locale("en", ''),
    Locale('ar', ''),
  ];

  Iterable<LocalizationsDelegate<dynamic>> get localizationsDelegates => [
    const AppLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  LocaleResolutionCallback get localeResolutionCallback =>
          (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      };
}

