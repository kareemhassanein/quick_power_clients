import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Quick_Power/bloc/profile/profile_event.dart';

import '../../bloc/general_states.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../constrants/colors.dart';
import '../../localization/Language/Languages.dart';
import '../../models/user_model.dart';
import '../widgets/widgets.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String type;
  final String? codeOtp;
  const ChangePasswordScreen({Key? key, required this.type, this.codeOtp}) : super(key: key);
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late ProfileBloc bloc;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  late StateSetter _stateSetter;
  bool passwordVisable = false;
  bool passwordConfirmVisable = false;

  @override
  void initState() {
    super.initState();
    bloc = ProfileBloc();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors().primaryColor,
          title: Text(
            Languages.of(context)!.changePassword,
            style: GoogleFonts.kufam(
              fontSize: 16.0.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(12.0.r),
            ),
          ),
        ),
        backgroundColor: AppColors().backgroundColor,
        body: BlocListener<ProfileBloc, GeneralStates>(
          bloc: bloc,
          listener: (context, state) {
            if (state is SuccessState) {
              Navigator.pop(context);
            }
          },
          child: BlocBuilder<ProfileBloc, GeneralStates>(
              bloc: bloc,
              builder: (context, state) {

                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        filedText(
                            onPasswordChange: (){
                              setState(() {
                                passwordVisable = !passwordVisable;
                              });
                            },
                            passwordVisible: passwordVisable,
                            label: '${Languages.of(context)!.newPassword}*', onChange: (s){
                          _stateSetter((){});
                        }, prefix: Icon(CupertinoIcons.lock_fill, color: AppColors().primaryColor), isPassword: true,controller: _passwordController, inputType: TextInputType.name, textInputAction: TextInputAction.next, validator: (s){
                          if(s!.isEmpty){
                            return Languages.of(context)!.required;
                          }
                          return null;
                        }),
                        SizedBox(height: 24.h,),
                        filedText( onPasswordChange: (){
                          setState(() {
                            passwordConfirmVisable = !passwordConfirmVisable;
                          });
                        },
                            passwordVisible: passwordConfirmVisable,
                            label: '${Languages.of(context)!.confirmNewPassword}*',  onChange: (s){
                          _stateSetter((){});
                        },prefix: Icon(CupertinoIcons.lock_fill, color: AppColors().primaryColor), isPassword: true,controller: _confirmController, inputType: TextInputType.name, textInputAction: TextInputAction.next, validator: (s){
                          return null;
                        }),
                        SizedBox(height: 32.h,),
                        SizedBox(
                          width: double.infinity,
                          child: StatefulBuilder(
                              builder: (context, snapshot) {
                                _stateSetter = snapshot;
                                return ElevatedButton(
                                    style: ButtonStyle(
                                        elevation: const MaterialStatePropertyAll(0.0),
                                        overlayColor: const MaterialStatePropertyAll(Colors.white12),
                                        backgroundColor: MaterialStatePropertyAll(AppColors().primaryColor.withOpacity((_passwordController.text.length>=4 && _confirmController.text.length>=4) ? 1.0 : 0.25) ),
                                        padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 8.h)),
                                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12.r)
                                        ))
                                    ),
                                    onPressed: (_passwordController.text.length>=4 && _confirmController.text.length>=4) ? (){
                                      bloc.add(ChangePasswordEvent({
                                        'user_otp' : widget.codeOtp.toString(),
                                        'password' : _passwordController.text,
                                        'password_confirmation' : _confirmController.text,
                                      }));
                                    } : null,
                                    child: Text(Languages.of(context)!.save, style: GoogleFonts.readexPro(
                                      fontSize: 22.0.sp,
                                      color: AppColors().backgroundColor,
                                      fontWeight: FontWeight.w600,
                                    ),));
                              }
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
