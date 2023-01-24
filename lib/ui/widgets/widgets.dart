import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constrants/colors.dart';


Widget filedTextAuth({
      String? hint,
      IconData? icon,
      bool? isPassword,
      required TextEditingController controller,
      required TextInputType inputType,
      required TextInputAction textInputAction,
      Function? onSubmit,
      FocusNode? focusNode,
  bool? enabled,
      bool? passwordVisible,
      List<TextInputFormatter>? inputFormatters,
      Widget? suffix,
      Widget? prefix,
      required String? Function(String?)? validator,
      String? errorText}) =>
    TextFormField(
      controller: controller,
      keyboardType: inputType,
      autovalidateMode: AutovalidateMode.disabled,
      textInputAction: textInputAction,
      validator: validator,
      focusNode: focusNode,
      obscureText: isPassword != null ,
      autocorrect: false,
      inputFormatters: inputFormatters,
      enableSuggestions: true,
      textAlign: TextAlign.start,
      enabled: enabled,
      maxLines: 1,
      cursorColor: AppColors().primaryColor,
      autofocus: false,
      decoration: InputDecoration(
        suffixIcon: suffix,
          prefixStyle: GoogleFonts.poppins(
            fontSize: 18.0.sp,
            color: const Color(0xFF121214).withOpacity(0.56),
          ),
          prefixIcon: Padding(
            padding: EdgeInsetsDirectional.only(end: 15.w),
            child: prefix,
          ),
          hoverColor: AppColors().primaryColor,
          // control your hints text size
          isDense: false,
          hintText: hint,
          prefixIconConstraints: BoxConstraints(
              maxWidth: 150.w, minWidth: 43.w,minHeight: 50.h, maxHeight: 50.h),
          hintStyle: GoogleFonts.poppins(
            fontSize: 18.0.sp,
            color: const Color(0xFF121214).withOpacity(0.56),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors().titleColor.withOpacity(0.75)),
          ),
          errorStyle: GoogleFonts.poppins(
            fontSize: 14.0.sp,
            color: Colors.red,
          ),
          focusColor: AppColors().primaryColor),
      style: GoogleFonts.poppins(
        fontSize: 18.0.sp,
        color: AppColors().titleColor,
      ),
    );

Widget loadingWidget({Color? color})=> Center(child: SpinKitRing
  (
  color: color??AppColors().primaryColor,
  size: 50.0.sp,
  lineWidth: 5.r,
),);