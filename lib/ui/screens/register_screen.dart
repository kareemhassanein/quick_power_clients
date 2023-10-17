import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Quick_Power/localization/Language/Languages.dart';

import '../../bloc/auth/login_bloc.dart';
import '../../bloc/auth/login_event.dart';
import '../../bloc/general_states.dart';
import '../../constrants/colors.dart';
import '../functions/functions.dart';
import '../widgets/auth_background.dart';
import '../widgets/widgets.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with TickerProviderStateMixin {
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _userId = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  late AnimationController _animationController;
  final AuthBloc _bloc = AuthBloc();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
            BlocListener<AuthBloc, GeneralStates>(
              bloc: _bloc,
              listener: (context, state) {
                if (state is SuccessState) {
                  _bloc.close();
                  navigateToScreen(context, const HomeScreen(),
                      withRemoveUntil: true);
                } else if (state is ErrorState) {
                  Future.delayed(const Duration(milliseconds: 300), (){
                    formKey.currentState!.validate();
                  });
                }
              },
              child: SingleChildScrollView(
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
                            children: [
                              SizedBox(
                                height: 40.h,
                              ),
                              Text(
                                Languages.of(context)!.signUp,
                                style: GoogleFonts.readexPro(
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
                                Languages.of(context)!.plsSignUp,
                                style: GoogleFonts.readexPro(
                                  fontSize: 16.0.sp,
                                  color: const Color(0xFF121214).withOpacity(0.7),
                                  height: 1.87.h,
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
                                      return Languages.of(context)!.required;
                                    } else if (state is ErrorState &&
                                        state.errors?.name != null) {
                                      return state.errors.name.first;
                                    }
                                    return null;
                                  },
                                  hint: Languages.of(context)!.name),
                              SizedBox(
                                height: 27.5.h,
                              ),
                              filedTextAuth(
                                  controller: _phoneController,
                                  inputType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  prefix: Icon(CupertinoIcons.phone_fill, color: AppColors().primaryColor, size: 24.r,),
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
                              SizedBox(
                                height: 27.5.h,
                              ),
        filedTextAuth(
                                  controller: _userId,
                                  inputType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  prefix: Icon(CupertinoIcons.person_alt_circle, color: AppColors().primaryColor, size: 24.r,),
                                  textInputAction: TextInputAction.next,
                                  validator: (s) {
                                    if (s!.isEmpty) {
                                      return Languages.of(context)!.required;
                                    }
                                    return null;
                                  },
                                  hint: 'User Id'),

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
                                      return Languages.of(context)!.required;
                                    } else if (state is ErrorState &&
                                        state.errors?.userPassword != null) {
                                      return state.errors.userPassword.first;
                                    }
                                    return null;
                                  },
                                  hint: Languages.of(context)!.enterPassword),
                              SizedBox(
                                height: 27.5.h,
                              ),
                              filedTextAuth(
                                  controller: _confirmPasswordController,
                                  inputType: TextInputType.visiblePassword,
                                  isPassword: true,
                                  prefix: Icon(Icons.lock, color: AppColors().primaryColor, size: 24.r,),
                                  textInputAction: TextInputAction.done,
                                  onSubmit: (){
                                    _bloc.add(InitialEvent());
                                    Future.delayed(
                                        const Duration(milliseconds: 100),
                                            () {
                                          if (formKey.currentState!.validate()) {
                                            _bloc.add(DoRegisterEvent(
                                                userPhone:
                                                _phoneController.text,
                                                userId: _userId.text,
                                                userPassword:
                                                _passwordController.text,
                                                userConfirmPassword: _confirmPasswordController.text,
                                                userName: _customerNameController.text));
                                          }
                                        });
                                  },
                                  validator: (s) {
                                    if (s!.isEmpty) {
                                      return Languages.of(context)!.required;
                                    } else if (state is ErrorState &&
                                        state.errors?.userConfirmPassword != null) {
                                      return state.errors.userConfirmPassword.first;
                                    }
                                    return null;
                                  },
                                  hint: Languages.of(context)!.confirmPassword),
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
                                    onPressed: (){
                                      _bloc.add(InitialEvent());
                                      Future.delayed(
                                          const Duration(milliseconds: 100),
                                              () {
                                            if (formKey.currentState!.validate()) {
                                              _bloc.add(DoRegisterEvent(
                                                  userPhone:
                                                  _phoneController.text,

                                                  userId: _userId.text,
                                                  userPassword:
                                                  _passwordController.text,
                                              userConfirmPassword: _confirmPasswordController.text,
                                              userName: _customerNameController.text));
                                            }
                                          });
                                    }, child:
                                Text(
                                  Languages.of(context)!.signUp,
                                  style: GoogleFonts.readexPro(
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
                                      style: GoogleFonts.readexPro(
                                        fontSize: 16.5.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        height: 1.87.h,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '${Languages.of(context)!.alreadyHaveAccount} ',
                                        ),
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
                              SizedBox(height: 40.0.h,),
                            ],
                          ),
                        );
                      },
                    ),
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
