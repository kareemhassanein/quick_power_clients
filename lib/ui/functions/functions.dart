import 'dart:io';
import 'package:flutter/material.dart';

Future<dynamic> navigateToScreen(BuildContext context, Widget navigateTo,
    {Duration? transitionDuration,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transitionsBuilder,
    bool? withRemoveUntil}) {
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
