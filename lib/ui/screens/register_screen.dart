import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../constrants/colors.dart';
import '../widgets/auth_background.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with TickerProviderStateMixin {
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 0))..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().backgroundColor,
      body: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Stack(
          children: [
            AuthBackground(animatedContainer: _animationController,),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      Text(
                        'Sign Up',
                        style: GoogleFonts.poppins(
                          fontSize: 38.0.sp,
                          color: Colors.black,
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
                        'Please Sign Up to your Account to Continue\nwith App.',
                        style: GoogleFonts.poppins(
                          fontSize: 16.0.sp,
                          color: const Color(0xFF121214).withOpacity(0.7),
                          height: 1.87.h,
                        ),
                      ),
                  // Group: Group 62712
                  Center(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        _selectedImage =  await _picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                        });
                      },
                      child: SizedBox(
                        width: 109.0.r,
                        height: 109.0.r,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              alignment: const Alignment(0.09, 0.0),
                              width: 106.0.w,
                              height: 105.0.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(53.0.r),
                                border: Border.all(
                                  width: 3.0.r,
                                  color: AppColors().primaryColor,
                                ),
                              ),
                              child: SizedBox(
                                width: 95.0.r,
                                height: 95.0.r,
                                child: ClipOval(child: _selectedImage != null ? Image.file(File(_selectedImage!.path), fit: BoxFit.cover,) : Image.asset('assets/logo.png')),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                alignment: Alignment.center,

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.elliptical(18.0.r, 17.5.r)),
                                  color: AppColors().primaryColor,
                                ),
                                child:  Padding(
                                  padding:  EdgeInsets.all(6.0.r),
                                  child: Icon(Icons.camera_alt_rounded, size: 24.r, color: Colors.white,),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                      SizedBox(
                        height: 27.5.h,
                      ),
                      filedTextAuth(
                          controller: _customerNameController,
                          inputType: TextInputType.text,
                          prefix: Icon(CupertinoIcons.building_2_fill, color: AppColors().primaryColor, size: 24.r,),
                          textInputAction: TextInputAction.next,
                          validator: (s) {
                            if (s!.isEmpty) {
                              return 'required';
                            }
                            return null;
                          },
                          hint: 'Customer Name'),
                      SizedBox(
                        height: 27.5.h,
                      ),
                      filedTextAuth(
                          controller: _emailController,
                          inputType: TextInputType.emailAddress,
                          prefix: Icon(CupertinoIcons.mail_solid, color: AppColors().primaryColor, size: 24.r,),
                          textInputAction: TextInputAction.next,
                          validator: (s) {
                            if (s!.isEmpty) {
                              return 'required';
                            }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(s)){
                              return 'Invalid Email';
                            }
                            return null;
                          },
                          hint: 'Email'),
                      SizedBox(
                        height: 27.5.h,
                      ),
                      filedTextAuth(
                          controller: _locationController,
                          inputType: TextInputType.text,
                          enabled: false,
                          prefix: Icon(CupertinoIcons.location_solid, color: AppColors().primaryColor, size: 24.r,),
                          suffix: Icon(Icons.my_location_rounded, color: AppColors().primaryColor, size: 24.r,),
                          textInputAction: TextInputAction.next,
                          validator: (s) {
                            if (s!.isEmpty) {
                              return 'required';
                            }
                            return null;
                          },
                          hint: 'Location'),
                      SizedBox(
                        height: 27.5.h,
                      ),
                      filedTextAuth(
                          controller: _passwordController,
                          inputType: TextInputType.visiblePassword,
                          isPassword: true,
                          prefix: Icon(Icons.lock, color: AppColors().primaryColor, size: 24.r,),
                          textInputAction: TextInputAction.next,
                          validator: (s) {
                            if (s!.isEmpty) {
                              return 'required';
                            }
                            return null;
                          },
                          hint: 'Enter Password'),
                      SizedBox(
                        height: 27.5.h,
                      ),
                      filedTextAuth(
                          controller: _confirmPasswordController,
                          inputType: TextInputType.visiblePassword,
                          isPassword: true,
                          prefix: Icon(Icons.lock, color: AppColors().primaryColor, size: 24.r,),
                          textInputAction: TextInputAction.done,
                          validator: (s) {
                            if (s!.isEmpty) {
                              return 'required';
                            }
                            return null;
                          },
                          hint: 'Confirm Password'),
                      SizedBox(height: 33.5.h,),
                      Center(
                        child: TextButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 70.h, vertical: 10.h)),
                                backgroundColor: MaterialStateProperty.all(AppColors().primaryColor),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40.0.r),
                                    ))
                            ),
                            onPressed: (){}, child:
                        Text(
                          'Sign Up',
                          style: GoogleFonts.poppins(
                            fontSize: 24.0.sp,
                            color: AppColors().backgroundColor,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        )),
                      ),
                      SizedBox(height: 33.0.h,),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Text.rich(
                            TextSpan(
                              style: GoogleFonts.poppins(
                                fontSize: 16.5.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                height: 1.87.h,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Already have an account. ',
                                ),
                                TextSpan(
                                  text: 'SIGN IN',
                                  style: GoogleFonts.poppins(
                                    color: AppColors().primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: 40.0.h,),
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
