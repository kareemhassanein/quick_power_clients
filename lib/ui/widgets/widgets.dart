import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constrants/colors.dart';


Widget filedTextAuth(
        {String? hint,
        IconData? icon,
          bool isPassword = false,
        required TextEditingController controller,
        required TextInputType inputType,
        required TextInputAction textInputAction,
        Function? onSubmit,
        FocusNode? focusNode,

        bool? enabled,
          bool passwordVisible = true,
          Function()? onPasswordChange,

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
      obscureText: isPassword && ! passwordVisible,
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
          prefixStyle: GoogleFonts.readexPro(
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
          suffix: isPassword ? GestureDetector(
            onTap: onPasswordChange,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 16.w),
              child: Icon(
                passwordVisible!
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
            ),
          ) : null,
          hintText: hint,
          prefixIconConstraints: BoxConstraints(
              maxWidth: 150.w,
              minWidth: 43.w,
              minHeight: 50.h,
              maxHeight: 50.h),
          hintStyle: GoogleFonts.readexPro(
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
            borderSide:
                BorderSide(color: AppColors().titleColor.withOpacity(0.75)),
          ),
          errorStyle: GoogleFonts.readexPro(
            fontSize: 14.0.sp,
            color: Colors.red,
          ),
          focusColor: AppColors().primaryColor),
      style: GoogleFonts.readexPro(
        fontSize: 18.0.sp,
        color: AppColors().titleColor,
      ),
    );

Widget filedText(
        {String? label,
        String? hint,
        IconData? icon,
        bool isPassword = false,
        required TextEditingController controller,
        required TextInputType inputType,
        required TextInputAction textInputAction,
        Function(String?)? onChange,
        Function? onSubmit,
        FocusNode? focusNode,
        bool? enabled,
          bool passwordVisible = true,
          Function()? onPasswordChange,

          List<TextInputFormatter>? inputFormatters,
        Widget? suffix,
        Widget? prefix,
        required String? Function(String?)? validator,
        String? errorText}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label,
            style: GoogleFonts.readexPro(
              fontSize: 16.0.sp,
              fontWeight: FontWeight.w500,
              color: AppColors().titleColor,
            ),
          ),
        SizedBox(
          height: 8.h,
        ),
        Container(
            alignment: Alignment(-0.07.r, 0.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, 1.0.r),
                  blurRadius: 3.0.r,
                ),
              ],
            ),
            child: TextFormField(
              controller: controller,
              keyboardType: inputType,
              onChanged: onChange,
              autovalidateMode: AutovalidateMode.disabled,
              textInputAction: textInputAction,
              validator: validator,
              focusNode: focusNode,
              obscureText: isPassword && ! passwordVisible,
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
                  prefixStyle: GoogleFonts.readexPro(
                    fontSize: 18.0.sp,
                    color: const Color(0xFF121214).withOpacity(0.56),
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: prefix,
                  ),
                  hoverColor: AppColors().primaryColor,
                  // control your hints text size
                  isDense: false,
                  hintText: hint,
                  suffix: isPassword ? GestureDetector(
                    onTap: onPasswordChange,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 16.w),
                      child: Icon(
                        passwordVisible!
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ) : null,
                  prefixIconConstraints: BoxConstraints(
                      maxWidth: 150.w,
                      minWidth: 43.w,
                      minHeight: 50.h,
                      maxHeight: 50.h),
                  hintStyle: GoogleFonts.readexPro(
                    fontSize: 18.0.sp,
                    color: const Color(0xFF121214).withOpacity(0.56),
                  ),
                  border: InputBorder.none,
                  errorStyle: GoogleFonts.readexPro(
                    fontSize: 14.0.sp,
                    color: Colors.red,
                  ),
                  focusColor: AppColors().primaryColor),
              style: GoogleFonts.readexPro(
                fontSize: 18.0.sp,
                color: AppColors().titleColor,
              ),
            )),
      ],
    );

Widget loadingWidget({Color? color}) => Center(
      child: SpinKitRing(
        color: color ?? AppColors().primaryColor,
        size: 50.0.sp,
        lineWidth: 3.r,
      ),
    );

Widget imageNetwork(String url, {BoxFit boxFit = BoxFit.cover}) =>
    CachedNetworkImage(
      imageUrl: url,
      fit: boxFit,
      placeholder: (
        context,
        url,
      ) =>
          loadingWidget(),
      errorWidget: (context, url, error) => const Icon(Icons.close_rounded),
    );
