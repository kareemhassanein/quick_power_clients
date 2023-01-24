import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

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
            transitionDuration: transitionDuration ?? Duration.zero,
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
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
            child: child
          )),
    ),
    context: context,
  );



