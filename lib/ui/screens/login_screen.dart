import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waqoodi_client/bloc/general_states.dart';

import 'package:waqoodi_client/constrants/colors.dart';
import 'package:waqoodi_client/localization/Language/Languages.dart';
import 'package:waqoodi_client/models/auth/auth_model.dart';
import 'package:waqoodi_client/ui/functions/functions.dart';
import 'package:waqoodi_client/ui/screens/home_screen.dart';
import 'package:waqoodi_client/ui/screens/register_screen.dart';
import 'package:waqoodi_client/ui/widgets/auth_background.dart';
import 'package:waqoodi_client/ui/widgets/widgets.dart';

import '../../bloc/auth/login_bloc.dart';
import '../../bloc/auth/login_event.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late AnimationController _animationController;
  final AuthBloc _bloc = AuthBloc();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors().backgroundColor,
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Stack(
          children: [
            AuthBackground(
              animatedContainer: _animationController,
            ),
            BlocListener<AuthBloc, GeneralStates>(
              bloc: _bloc,
              listener: (context, state) {
                if (state is SuccessState) {
                  _bloc.close();
                  navigateToScreen(context, const HomeScreen(),
                      withRemoveUntil: true);
                } else if (state is ErrorState) {
                  print('ddsd');
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
                                  Languages.of(context)!.signIn,
                                style: GoogleFonts.readexPro(
                                  fontSize: 38.0.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 18.h,
                              ),
                              SizeTransition(
                                sizeFactor: Tween(begin: 0.0, end: 1.0).animate(
                                    CurvedAnimation(
                                        parent: _animationController,
                                        curve: Curves.easeInOutBack)),
                                axis: Axis.horizontal,
                                child: Container(
                                  color: AppColors().primaryColor,
                                  width: 64.w,
                                  height: 6.h,
                                ),
                              ),
                              SizedBox(
                                height: 46.h,
                              ),
                              Text(
                                Languages.of(context)!.plsSignIn,
                                style: GoogleFonts.readexPro(
                                  fontSize: 16.0.sp,
                                  color:
                                      const Color(0xFF121214).withOpacity(0.7),
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
                              SizedBox(
                                height: 45.5.h,
                              ),
                              filedTextAuth(
                                  controller: _passwordController,
                                  inputType: TextInputType.visiblePassword,
                                  isPassword: true,
                                  prefix: Icon(
                                    Icons.lock,
                                    color: AppColors().primaryColor,
                                    size: 24.r,
                                  ),
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
                                height: 12.5.h,
                              ),
                              Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {},
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    child: Text(
                                      Languages.of(context)!.forgerPassword,
                                      style: GoogleFonts.readexPro(
                                          fontSize: 16.0.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 80.h,
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
                                                AppColors().primaryColor),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40.0.r),
                                        ))),
                                    onPressed: () {
                                      _bloc.add(InitialEvent());
                                      Future.delayed(
                                          const Duration(milliseconds: 100),
                                          () {
                                        if (formKey.currentState!.validate()) {
                                          _bloc.add(DoLoginEvent(
                                              userEmail:
                                                  _usernameController.text,
                                              userPassword:
                                                  _passwordController.text));
                                        }
                                      });
                                    },
                                    child: Text(
                                      Languages.of(context)!.signIn,
                                      style: GoogleFonts.readexPro(
                                        fontSize: 24.0.sp,
                                        color: AppColors().backgroundColor,
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
                                  navigateToScreen(
                                      context, const RegisterScreen(),
                                      transitionDuration:
                                          const Duration(milliseconds: 3000));
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
                                          text: '${Languages.of(context)!.dontHaveAnAccount}\n',
                                        ),
                                        TextSpan(
                                          text: Languages.of(context)!.signUp.toUpperCase(),
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
