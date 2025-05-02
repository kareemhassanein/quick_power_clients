import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Quick_Power/constrants/colors.dart';
import 'package:Quick_Power/preference.dart';
import 'package:Quick_Power/ui/functions/functions.dart';
import 'package:Quick_Power/ui/screens/home_screen.dart';
import 'package:Quick_Power/ui/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController controller2;
  double smallLogo = 100;
  double bigLogo = 200;
  @override
  void initState() {
    super.initState();
    controller2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3500))
      ..forward().then((value) => controller2.forward().then((value) =>
          navigateToScreen(context, const HomeScreen(), transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          }, transitionDuration: const Duration(milliseconds: 1200), withRemoveUntil: true)));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors().primaryColor,
      body: LayoutBuilder(builder: (context, constraints) {
        final Size biggest = constraints.biggest;
        return Stack(
          children: [
            Center(
              child: ScaleTransition(
                scale: Tween(begin: 0.4, end: 1.0).animate(CurvedAnimation(
                  parent: controller,
                  curve: Curves.elasticOut,
                )),
                child: FadeTransition(
                  opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                    parent: controller,
                    curve: Curves.linear,
                  )),
                  child: RotationTransition(
                    turns: Tween(begin: 1.25, end: 1.0).animate(CurvedAnimation(
                      parent: controller,
                      curve: Curves.elasticOut,
                    )),
                    child: ScaleTransition(
                      scale: Tween(begin: 1.0, end: 8.8).animate(
                          CurvedAnimation(
                              parent: controller2, curve: Curves.easeInExpo)),
                      child: SvgPicture.string(
                        '<svg viewBox="2075.18 649.62 328.73 349.18" ><path  d="M 2308.5185546875 649.6337280273438 C 2393.5927734375 648.3876953125 2403.915283203125 742.2747192382812 2403.915283203125 827.3270874023438 C 2403.915283203125 912.37939453125 2274.50390625 998.80126953125 2189.420654296875 998.80126953125 C 2104.33740234375 998.80126953125 2076.029296875 932.0543823242188 2075.187744140625 847.0062866210938 C 2074.411376953125 768.5512084960938 2223.288330078125 650.8817749023438 2308.5185546875 649.6337280273438 Z" fill="#ffffff" fill-opacity="0.24" stroke="none" stroke-width="1" stroke-opacity="0.24" stroke-miterlimit="10" stroke-linecap="butt" /></svg>',
                        width: 328.73.w,
                        height: 349.18.h,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            PositionedTransition(
              rect: RelativeRectTween(
                begin: RelativeRect.fromSize(
                    Rect.fromLTWH(200, -150.h, 150.w, 150.h), biggest),
                end: RelativeRect.fromSize(
                    Rect.fromLTWH(-100.w, -100.h, 308.12.w, 308.0.h), biggest),
              ).animate(CurvedAnimation(
                parent: controller,
                curve: Curves.elasticOut,
              )),
              child: FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(controller),
                child: ScaleTransition(
                  scale: Tween(begin: 1.0, end: 8.8).animate(CurvedAnimation(
                      parent: controller2, curve: Curves.easeInExpo)),
                  child: SvgPicture.string(
                    '<svg viewBox="1977.0 292.81 308.12 308.0" ><path transform="translate(1977.0, 292.81)" d="M 154.0599975585938 0 C 239.1449890136719 0 308.1199951171875 68.94815826416016 308.1199951171875 154 C 308.1199951171875 239.0518493652344 239.1449890136719 308 154.0599975585938 308 C 68.97501373291016 308 0 239.0518493652344 0 154 C 0 68.94815826416016 68.97501373291016 0 154.0599975585938 0 Z" fill="#ffffff" fill-opacity="0.08" stroke="none" stroke-width="1" stroke-opacity="0.08" stroke-miterlimit="10" stroke-linecap="butt" /></svg>',
                    width: 308.12.w,
                    height: 308.0.h,
                  ),
                ),
              ),
            ),
            PositionedTransition(
              rect: RelativeRectTween(
                begin: RelativeRect.fromSize(
                    Rect.fromLTWH(0.w, -150.h, 150.w, 150.h), biggest),
                end: RelativeRect.fromSize(
                    Rect.fromLTWH(100.w, -135.h, 308.12.w, 308.0.h), biggest),
              ).animate(CurvedAnimation(
                parent: controller,
                curve: Curves.elasticOut,
              )),
              child: FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(controller),
                child: ScaleTransition(
                  scale: Tween(begin: 1.0, end: 8.8).animate(CurvedAnimation(
                      parent: controller2, curve: Curves.easeInExpo)),
                  child: SvgPicture.string(
                    '<svg viewBox="1977.0 292.81 308.12 308.0" ><path transform="translate(1977.0, 292.81)" d="M 154.0599975585938 0 C 239.1449890136719 0 308.1199951171875 68.94815826416016 308.1199951171875 154 C 308.1199951171875 239.0518493652344 239.1449890136719 308 154.0599975585938 308 C 68.97501373291016 308 0 239.0518493652344 0 154 C 0 68.94815826416016 68.97501373291016 0 154.0599975585938 0 Z" fill="#ffffff" fill-opacity="0.08" stroke="none" stroke-width="1" stroke-opacity="0.08" stroke-miterlimit="10" stroke-linecap="butt" /></svg>',
                    width: 308.12.w,
                    height: 308.0.h,
                  ),
                ),
              ),
            ),
            PositionedTransition(
              rect: RelativeRectTween(
                begin: RelativeRect.fromSize(
                    Rect.fromLTWH(0, constraints.maxHeight, 150.w, 150.h),
                    biggest),
                end: RelativeRect.fromSize(
                    Rect.fromLTWH(constraints.maxWidth - 120.w,
                        constraints.maxHeight - 290.h, 308.12.w, 308.0.h),
                    biggest),
              ).animate(CurvedAnimation(
                parent: controller,
                curve: Curves.elasticOut,
              )),
              child: FadeTransition(
                opacity: Tween(begin: 0.3, end: 1.0).animate(controller),
                child: ScaleTransition(
                  scale: Tween(begin: 1.0, end: 8.8).animate(CurvedAnimation(
                      parent: controller2, curve: Curves.easeInExpo)),
                  child: SvgPicture.string(
                    '<svg viewBox="1977.0 292.81 308.12 308.0" ><path transform="translate(1977.0, 292.81)" d="M 154.0599975585938 0 C 239.1449890136719 0 308.1199951171875 68.94815826416016 308.1199951171875 154 C 308.1199951171875 239.0518493652344 239.1449890136719 308 154.0599975585938 308 C 68.97501373291016 308 0 239.0518493652344 0 154 C 0 68.94815826416016 68.97501373291016 0 154.0599975585938 0 Z" fill="#ffffff" fill-opacity="0.08" stroke="none" stroke-width="1" stroke-opacity="0.08" stroke-miterlimit="10" stroke-linecap="butt" /></svg>',
                    width: 308.12.w,
                    height: 308.0.h,
                  ),
                ),
              ),
            ),
            PositionedTransition(
              rect: RelativeRectTween(
                begin: RelativeRect.fromSize(
                    Rect.fromLTWH(constraints.maxWidth, constraints.maxHeight,
                        150.w, 150.h),
                    biggest),
                end: RelativeRect.fromSize(
                    Rect.fromLTWH(constraints.maxWidth - 300.w,
                        constraints.maxHeight - 192.h, 308.12.w, 308.0.h),
                    biggest),
              ).animate(CurvedAnimation(
                parent: controller,
                curve: Curves.elasticOut,
              )),
              child: FadeTransition(
                opacity: Tween(begin: 0.3, end: 1.0).animate(controller),
                child: ScaleTransition(
                  scale: Tween(begin: 1.0, end: 8.8).animate(CurvedAnimation(
                      parent: controller2, curve: Curves.easeInExpo)),
                  child: SvgPicture.string(
                    '<svg viewBox="1977.0 292.81 308.12 308.0" ><path transform="translate(1977.0, 292.81)" d="M 154.0599975585938 0 C 239.1449890136719 0 308.1199951171875 68.94815826416016 308.1199951171875 154 C 308.1199951171875 239.0518493652344 239.1449890136719 308 154.0599975585938 308 C 68.97501373291016 308 0 239.0518493652344 0 154 C 0 68.94815826416016 68.97501373291016 0 154.0599975585938 0 Z" fill="#ffffff" fill-opacity="0.08" stroke="none" stroke-width="1" stroke-opacity="0.08" stroke-miterlimit="10" stroke-linecap="butt" /></svg>',
                    width: 308.12.w,
                    height: 308.0.h,
                  ),
                ),
              ),
            ),
            Center(
                child: ScaleTransition(
              scale: Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
                  parent: controller2, curve: Curves.easeOutExpo)),
              child: Transform.scale(
                  scale: 0.45,
                  child: Image.asset(
                    'assets/logo.png',
                  )),
            )),
          ],
        );
      }),
    );
  }
}
