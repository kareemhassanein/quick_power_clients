import 'dart:async';

import 'package:Quick_Power/models/forget_password_model.dart';
import 'package:Quick_Power/ui/screens/otp_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../bloc/auth/login_bloc.dart';
import '../../bloc/auth/login_event.dart';
import '../../bloc/general_states.dart';
import '../../constrants/colors.dart';
import '../../localization/Language/Languages.dart';
import '../../localization/LanguageHelper.dart';
import '../functions/functions.dart';
import '../widgets/widgets.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final AuthBloc _bloc = AuthBloc();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool passwordVisable = false;
  Timer? _timer;
  int _countDown = 30;
  bool enableSending = true;


  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_countDown == 1) {
        timer.cancel();
        setState(() {
          enableSending = true;
        });
      } else {
        setState(() {
          _countDown--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Stack(
          children: [
            BlocListener<AuthBloc, GeneralStates>(
              bloc: _bloc,
              listener: (context, state) {
                if (state is SuccessState ) {
                  SendOtpModel model = state.response;
                  navigateToScreen(context, OtpScreen(otpCode: model.data?.code??0000));
                }else if (state is ErrorState) {
                  Future.delayed(const Duration(milliseconds: 300), (){
                    formKey.currentState!.validate();
                    setState(() {
                      _countDown = 0;
                      _timer!.cancel();
                      enableSending = true;
                    });
                  });
                }
              },
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                  child: BlocBuilder<AuthBloc, GeneralStates>(
                    bloc: _bloc,
                    builder: (context, state) {
                      return Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 40.h,
                                ),
                                Text(
                                  Languages.of(context)!.forgerPassword,
                                  style: GoogleFonts.readexPro(
                                    fontSize: 30.0.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),
                                Container(
                                  color: AppColors().primaryColor,
                                  width: 64.w,
                                  height: 6.h,
                                ),
                                SizedBox(
                                  height: 46.h,
                                ),
                                Text(
                                  Languages.of(context)!.forgetPasswordHint,
                                  style: GoogleFonts.readexPro(
                                    fontSize: 16.0.sp,

                                    height: 1.87.h,
                                  ),
                                ),
                                SizedBox(
                                  height: 48.h,
                                ),
                                filedTextAuth(
                                    controller: _usernameController,
                                    inputType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    prefix: Icon(
                                      CupertinoIcons.phone_fill,
                                      color: AppColors().primaryColor,
                                      size: 24.r,
                                    ),
                                    textInputAction: TextInputAction.next,
                                    validator: (s) {
                                      if (s!.isEmpty) {
                                        return Languages.of(context)!.required;
                                      } else if (state is ErrorState &&
                                          state.errors?.userMobile != null) {
                                        return state.errors.userMobile.first;
                                      }
                                      return null;
                                    },
                                    hint: Languages.of(context)!.phone),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Visibility(
                                  visible: !enableSending,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 24.h),
                                    child: Text(
                                      '${Languages.of(context)?.resendAfter} $_countDown ${Languages.of(context)?.seconds}',
                                      style: GoogleFonts.readexPro(
                                        fontSize: 16.0.sp,
                                        height: 1.87.h,
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: TextButton(
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.symmetric(
                                                  horizontal: 70.h,
                                                  vertical: 10.h)),
                                          backgroundColor:
                                          MaterialStateProperty.all(
                                              AppColors().primaryColor.withOpacity(enableSending ? 1.0 : 0.4)),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(40.0.r),
                                              ))),
                                      onPressed: !enableSending ? null : () {
                                        _bloc.add(InitialEvent());
                                        Future.delayed(
                                            const Duration(milliseconds: 100),
                                                () {
                                              if (formKey.currentState!.validate()) {
                                                _bloc.add(SendOtpForgetPasswordEvent(
                                                    userPhone:
                                                    _usernameController.text,)
                                                );
                                              }
                                            });
                                        _countDown = 30;
                                        startTimer();
                                        enableSending = false;
                                      },
                                      child: Text(
                                        Languages.of(context)!.send,
                                        style: GoogleFonts.readexPro(
                                          fontSize: 24.0.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      )),
                                ),
                                SizedBox(
                                  height: 48.0.h,
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Center(
                                    child: Text.rich(
                                      TextSpan(
                                        style: GoogleFonts.readexPro(
                                          fontSize: 16.5.sp,

                                          fontWeight: FontWeight.w500,
                                          height: 1.87.h,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: Languages.of(context)!.signIn.toUpperCase(),
                                            style: GoogleFonts.readexPro(
                                              color: AppColors().primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 35.0.h,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );

  }
}
