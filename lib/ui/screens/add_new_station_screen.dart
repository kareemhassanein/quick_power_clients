import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constrants/colors.dart';

class AddNewStationScreen extends StatelessWidget {
  const AddNewStationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 16.h),
              alignment: Alignment(-0.89.r, 0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0.r),
                color: AppColors().backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.16),
                    offset: Offset(0, 3.0.r),
                    blurRadius: 6.0.r,
                  ),
                ],
              ),
              child: TextFormField(
                cursorColor: AppColors().primaryColor,
                cursorHeight: 18.h,
                decoration: InputDecoration(
                  isCollapsed: true,
                  contentPadding: EdgeInsets.only(
                      left: 16.w, right: 16.w, bottom: 12.h, top: 12.h),
                  border: InputBorder.none,
                  hintText: 'Name',
                  hintMaxLines: 1,
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 12.0.sp,
                    color: const Color(0xFF656565),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                minLines: 1,
                maxLines: 3,
                style: GoogleFonts.poppins(
                  fontSize: 14.0.sp,
                  color: Colors.black,
                ),
              )),
          Container(
              margin: EdgeInsets.only(bottom: 16.h),
              alignment: Alignment(-0.89.r, 0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0.r),
                color: AppColors().backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.16),
                    offset: Offset(0, 3.0.r),
                    blurRadius: 6.0.r,
                  ),
                ],
              ),
              child: TextFormField(
                cursorColor: AppColors().primaryColor,
                cursorHeight: 18.h,
                decoration: InputDecoration(
                  isCollapsed: true,
                  contentPadding: EdgeInsets.only(
                      left: 16.w, right: 16.w, bottom: 12.h, top: 12.h),
                  border: InputBorder.none,
                  hintText: 'Address',
                  hintMaxLines: 1,
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 12.0.sp,
                    color: const Color(0xFF656565),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                minLines: 4,
                maxLines: 5,
                style: GoogleFonts.poppins(
                  fontSize: 14.0.sp,
                  color: Colors.black,
                ),
              )),
          // Group: Group 62797
          Container(
            alignment: Alignment(-0.07.r, 0.0),
            height: 45.0.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.16),
                  offset: Offset(0, 3.0.r),
                  blurRadius: 6.0.r,
                ),
              ],
            ),
            child: SizedBox(
              height: 16.0.h,
              child: Row(
                children: <Widget>[
                  const Spacer(flex: 13),
                  Text(
                    'Location',
                    style: GoogleFonts.poppins(
                      fontSize: 11.0.sp,
                      color: const Color(0xFF656565),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(flex: 192),
                  SvgPicture.string(
                    // Icon material-location-on
                    '<svg viewBox="252.5 12.5 10.5 15.0" ><path transform="translate(245.0, 9.5)" d="M 12.75 3 C 9.847499847412109 3 7.5 5.347499847412109 7.5 8.25 C 7.5 12.1875 12.75 18 12.75 18 C 12.75 18 18 12.1875 18 8.25 C 18 5.347499847412109 15.65250015258789 3 12.75 3 Z M 12.75 10.125 C 11.71500015258789 10.125 10.875 9.284999847412109 10.875 8.25 C 10.875 7.215000152587891 11.71500015258789 6.375 12.75 6.375 C 13.78499984741211 6.375 14.625 7.215000152587891 14.625 8.25 C 14.625 9.284999847412109 13.78499984741211 10.125 12.75 10.125 Z" fill="#39969b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                    width: 10.5,
                    height: 15.0,
                  ),
                  Spacer(flex: 15),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h,),
          Center(
            child: TextButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(
                            horizontal: 34.w,
                            vertical: 10.h)),
                    backgroundColor:
                    MaterialStateProperty.all(
                        AppColors().primaryColor),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(10.0.r),
                        ))),
                onPressed: () {

                },
                child: Text(
                  'Submit ',
                  style: GoogleFonts.poppins(
                    fontSize: 15.0.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),),
          ),
        ],
      ),
    );
  }
}
