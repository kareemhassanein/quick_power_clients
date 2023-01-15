import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waqoodi_client/constrants/colors.dart';

class AuthBackground extends StatelessWidget {
  final AnimationController animatedContainer;
  const AuthBackground({Key? key, required this.animatedContainer}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Stack(
      children: [
        
        PositionedDirectional(
          start: -75.w,
          top: 0.0,
          child: ScaleTransition(
            scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animatedContainer, curve: Curves.easeInOutBack)),
            child: Container(
              width: 216.0.r,
              height: 216.0.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFE8D357).withOpacity(0.72),
              ),
            ),
          ),
        ),
        PositionedDirectional(
          end: -75.w,
          bottom: 0.0,
          child: ScaleTransition(
            scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animatedContainer, curve: Curves.easeInOutBack)),
            child: Container(
              width: 257.0.r,
              height: 257.0.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors().primaryColor.withOpacity(0.71),
              ),
            ),
          ),
        ),
        BackdropFilter(
          blendMode: BlendMode.src,
          filter: ImageFilter.blur(sigmaX: 50.0.r, sigmaY: 50.0.r),
          child: Container(),
        )
      ],
    );
  }
}
