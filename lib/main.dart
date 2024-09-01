import 'dart:async';
import 'dart:io';

import 'package:Quick_Power/firebase_options.dart';
import 'package:Quick_Power/repository/orders_repo.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
import 'package:timeago/timeago.dart' as timeago;

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

  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  Preferences().loaderInstance(savedThemeMode?? AdaptiveThemeMode.light);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  timeago.setLocaleMessages('en', timeago.EnMessages());
  timeago.setLocaleMessages('ar', timeago.ArMessages());
  runApp( StartApp(savedThemeMode: savedThemeMode,));
}


class StartApp extends StatefulWidget {
  AdaptiveThemeMode? savedThemeMode;
  StartApp({Key? key, this.savedThemeMode, }) : super(key: key);

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
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return AdaptiveTheme(
          light: ThemeData(

            textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                  textStyle: MaterialStatePropertyAll(GoogleFonts.alexandria(
                      fontSize: 14.0.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white
                  )),
                    foregroundColor: const MaterialStatePropertyAll(Colors.white),
                )
            ),
            dividerTheme: const DividerThemeData(
              color: Colors.black12,
            ),
            primaryColor: AppColors().primaryColor,
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: Colors.white), // Set dark theme color
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: BorderSide.none
                ),
                elevation: 4.r,
                highlightElevation: 5.r,
                backgroundColor: AppColors().primaryColor
            ),// Set
            primaryIconTheme: const IconThemeData(color: Colors.white),
            scaffoldBackgroundColor: Colors.grey.shade200,
            tabBarTheme: const TabBarTheme(
                labelColor: Colors.white,
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab
            ),
            buttonTheme: ButtonThemeData(
              buttonColor: AppColors().primaryColor,
              shape: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15.r),
              ),
              textTheme: ButtonTextTheme.normal,
            ),
            textTheme: TextTheme(
              headlineMedium: GoogleFonts.alexandria(
                  fontSize: 14.0.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white
              ),
              titleLarge: GoogleFonts.alexandria(
                fontSize: 14.0.sp,
                color: AppColors().backgroundColor,
                fontWeight: FontWeight.w800,
              ),
              titleMedium: GoogleFonts.alexandria(
                fontSize: 14.0.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w700,
              ),
              titleSmall: GoogleFonts.alexandria(
                  fontSize: 14.0.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors().primaryColor
              ),
              bodySmall: GoogleFonts.alexandria(
                  fontSize: 15.0.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54
              ),
              bodyMedium: GoogleFonts.alexandria(
                  fontSize: 15.0.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87
              ),
              bodyLarge: GoogleFonts.alexandria(
                  fontSize: 15.0.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87
              ),
            ),
            colorScheme: ColorScheme.light(
                secondary: AppColors().primaryColor,
                primary: AppColors().secnrdyColor
            ),
          ),
          dark: ThemeData(
            textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                  textStyle: MaterialStatePropertyAll(GoogleFonts.alexandria(
                      fontSize: 14.0.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white
                  )),
                  foregroundColor: const MaterialStatePropertyAll(Colors.white),
                )
            ),
            dividerTheme: const DividerThemeData(
              color: Colors.white12,
            ),
            tabBarTheme: const TabBarTheme(
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab
            ),
            scaffoldBackgroundColor: Colors.grey[850],
            brightness: Brightness.dark,
            cardColor: const Color(0xff403c3c),
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: Colors.white),
            ),
            primaryIconTheme: const IconThemeData(color: Colors.white), //
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: BorderSide.none
                ),
                elevation: 4.r,
                highlightElevation: 5.r,
                backgroundColor: AppColors().primaryColor
            ),// Set
            buttonTheme: ButtonThemeData(
              buttonColor: AppColors().primaryColor,
              shape: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15.r),
              ),
              textTheme: ButtonTextTheme.normal,
            ),
            textTheme: TextTheme(
              headlineMedium: GoogleFonts.alexandria(
                  fontSize: 14.0.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white
              ),
              titleLarge: GoogleFonts.alexandria(
                fontSize: 14.0.sp,
                color: AppColors().backgroundColor,
                fontWeight: FontWeight.w800,
              ),
              titleMedium: GoogleFonts.alexandria(
                fontSize: 14.0.sp,
                color: Colors.white.withOpacity(0.87),
                fontWeight: FontWeight.w700,
              ),
              titleSmall: GoogleFonts.alexandria(
                  fontSize: 15.0.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors().primaryColor
              ),
              bodySmall: GoogleFonts.alexandria(
                  fontSize: 15.0.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.9)
              ),
              bodyMedium: GoogleFonts.alexandria(
                  fontSize: 15.0.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.9)
              ),
              bodyLarge: GoogleFonts.alexandria(
                  fontSize: 15.0.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.9)
              ),
            ),
            colorScheme: ColorScheme.dark(
                secondary: AppColors().primaryColor,
                primary: AppColors().secnrdyColor
            ),
            primarySwatch: const MaterialColor(
              0xFFFFFFFF,
              <int, Color>{
                50: Color(0xFFFFFFFF),
                100: Color(0xFFFFFFFF),
                200: Color(0xFFFFFFFF),
                300: Color(0xFFFFFFFF),
                400: Color(0xFFFFFFFF),
                500: Color(0xFFFFFFFF),
                600: Color(0xFFFFFFFF),
                700: Color(0xFFFFFFFF),
                800: Color(0xFFFFFFFF),
                900: Color(0xFFFFFFFF),
              },
            ),

            primaryColor: AppColors().primaryColor,
          ),
          initial: widget.savedThemeMode ?? AdaptiveThemeMode.light,
          builder: (theme, darkTheme) =>
              MaterialApp(
                locale: _locale,
                supportedLocales: supportedLocales,
                localizationsDelegates: localizationsDelegates,
                localeResolutionCallback: localeResolutionCallback,
                debugShowCheckedModeBanner: false,
                theme: theme,
                darkTheme: darkTheme,
                home: child,
                builder: EasyLoading.init(),
              ),
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

