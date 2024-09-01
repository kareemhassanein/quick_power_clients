import 'package:Quick_Power/models/terms_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constrants/colors.dart';
import '../../localization/Language/Languages.dart';

class TermsScreen extends StatefulWidget {
  final TermsModel model;
  const TermsScreen({Key? key, required this.model}) : super(key: key);

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors().primaryColor,
        title: Text(
          Languages.of(context)!.termsAndConditions,
          style: GoogleFonts.alexandria(
            fontSize: 18.0.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(12.0.r),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 32.w),
          child: Text(
            widget.model.data?.isNotEmpty??false ? widget.model.data?.first.text ?? '' : '',
            textAlign: TextAlign.start,
            style: GoogleFonts.alexandria(
              fontSize: 16.6.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
