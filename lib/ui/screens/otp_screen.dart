import 'package:Quick_Power/constrants/colors.dart';
import 'package:Quick_Power/localization/Language/Languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';


import '../../constrants/apis.dart';
import '../functions/functions.dart';
import 'change_password_screen.dart';

class OtpScreen extends StatefulWidget {
  final int otpCode;
  const OtpScreen({Key? key, required this.otpCode}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final OtpFieldController _otpController = OtpFieldController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    Fluttertoast.showToast(
        msg: widget.otpCode.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
    );
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
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Form(
                  key: _formKey,
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
                            Languages.of(context)?.otpVerification??'',
                            style: TextStyle(
                              fontSize: 30.sp,
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
                            Languages.of(context)?.otpVerificationHint??'',
                            style: TextStyle(
                              fontSize: 16.0.sp,
                              height: 1.87.h,
                            ),
                          ),
                          SizedBox(
                            height: 48.h,
                          ),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: OTPTextField(
                              controller: _otpController,
                              otpFieldStyle: OtpFieldStyle(
                                focusBorderColor: AppColors().primaryColor,
                              ),
                              length: 4,
                              width: MediaQuery.of(context).size.width,
                              fieldStyle: FieldStyle.box,
                              textFieldAlignment: MainAxisAlignment.spaceEvenly,
                              fieldWidth: 60.w,
                              style: TextStyle(fontSize: 20.sp),
                              outlineBorderRadius: 10.r,
                              obscureText: false,
                              inputFormatter: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              onChanged: (pin) {
                              },
                              onCompleted: (pin) {
                                if(pin == widget.otpCode.toString()){
                                  navigateToScreen(
                                      context, ChangePasswordScreen(type: Apis.resetPassword, codeOtp: widget.otpCode.toString(),),
                                  customRoute: (r) => r.isFirst);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
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
