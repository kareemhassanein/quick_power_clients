import 'package:Quick_Power/constrants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 24.h,),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: SizedBox(
                  height: 120.h,
                  child: Image.asset('assets/logo.png')),
            ),
            Text('Quick Power | كويك باور', style: TextStyle(
              fontSize: 28.sp,
              color: Colors.white,
              fontWeight: FontWeight.w800
            ),),
            SizedBox(height: 32.h,),

            Expanded(
              child: IntroductionScreen(
                globalBackgroundColor: AppColors().primaryColor,
                safeAreaList: const [true, true, true,true],
                pages: listPagesViewModel,
                showSkipButton: true,
                showNextButton: false,
                rtl: true,
                skip: const Text("Skip"),
                done: const Text("Done"),
                onDone: () {
                  // On button pressed
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PageViewModel> listPagesViewModel = [
    PageViewModel(
      decoration: PageDecoration(
        fullScreen: false,

        boxDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24)
        )
      ),
      title: "Title of custom button page",
      body: "This is a description on a page with a custom button below.",

    ),    PageViewModel(
      title: "Title of custom button page",
      body: "This is a description on a page with a custom button below.",


    ),
  ];
}
