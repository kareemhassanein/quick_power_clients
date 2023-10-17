import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:Quick_Power/constrants/colors.dart';

import '../../localization/LanguageHelper.dart';




void showLanguagesDialog(BuildContext context) {
  int value = LanguageHelper.isEnglish ? 0 : 1;
  openDialog( context, (p0, p1, p2) =>  ListView.separated(
    shrinkWrap: true,
    itemCount: 2,
    padding: EdgeInsets.zero,
    itemBuilder: (context, index) {
      return RadioListTile(
        toggleable: true,
        shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20.r),
        ),
        value: index,
        groupValue: value,
        onChanged: (ind) {
          value = index;
          LanguageHelper.changeLanguage(
              context, index == 0 ? 'en' : 'ar');
          Navigator.pop(context);
        },
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text(
              index == 0 ? 'English' : 'العربية',
              style:  GoogleFonts
                  .readexPro(
                fontSize: 14.0.sp,
                fontWeight:
                FontWeight
                    .w500,
                color: AppColors().titleColor,
              )
            ),
          ],
        ),
        controlAffinity: ListTileControlAffinity.trailing,
      );
    },
    separatorBuilder: (BuildContext context, int index) => Padding(
      padding:  EdgeInsets.only(right: 20.w, left: 20.w),
      child: Divider(
        height: 1.h,
        thickness: 1,
      ),
    ),
  ));
}



Future<dynamic> navigateToScreen(BuildContext context, Widget navigateTo,
    {Duration? transitionDuration,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transitionsBuilder,
    bool? withRemoveUntil}) {
  FocusManager.instance.primaryFocus?.unfocus();
  if (Platform.isAndroid) {
    return Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
            opaque: false,
            pageBuilder: (_, __, ___) => navigateTo,
            transitionsBuilder:
                transitionsBuilder ?? (_, __, ___, ____) => ____),
        (c) => withRemoveUntil == null);
  } else {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (c) => navigateTo,
        ),
        (c) => withRemoveUntil == null);
  }
}

Future<void> openMap(double latitude, double longitude) async {
  String googleUrl =
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  if (await canLaunch(googleUrl)) {
    await launch(googleUrl);
  } else {
    throw 'Could not open the map.';
  }
}

Future<dynamic> openDialog(BuildContext context, Widget Function(BuildContext, Animation<double>, Animation<double>) itemBuilder) =>
  showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black12,
    transitionDuration: const Duration(milliseconds: 500),
    pageBuilder: itemBuilder,
    transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
      child: FadeTransition(
          opacity: anim1,
          child: Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
            child: child
          )),
    ),
    context: context,
  );

Future<DateTime?> selectDate(BuildContext context) async {
 return await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (c, child)=>  Theme(
     data: Theme.of(context).copyWith(
   colorScheme: ColorScheme.light(
     primary: AppColors().primaryColor, // header background color
     onPrimary: Colors.white, // header text color
     onSurface: Colors.black, // body text color
   ),
   textButtonTheme: TextButtonThemeData(
     style: TextButton.styleFrom(
       primary: AppColors().primaryColor,

     ),
   ),
 ),
  child: child!,
  ),
      lastDate: DateTime.now().add(const Duration(days: 8)));
}
double getTotal({required unitPrice, required quantity,}) {
  if(quantity.toString().isEmpty) {
    return 0.0;
  }
  return (unitPrice! * double.parse(quantity.toString().replaceAll(',', '')));
}


