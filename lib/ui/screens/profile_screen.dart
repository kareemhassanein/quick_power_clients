import 'dart:io';

import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Quick_Power/bloc/profile/profile_bloc.dart';
import 'package:Quick_Power/bloc/profile/profile_event.dart';
import 'package:Quick_Power/localization/Language/Languages.dart';
import 'package:Quick_Power/models/user_model.dart';
import 'package:Quick_Power/ui/widgets/widgets.dart';

import '../../bloc/general_states.dart';

import '../../constrants/colors.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileBloc bloc;
  UserModel? _userModel;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  late StateSetter _stateSetter;

  @override
  void initState() {
    super.initState();
    bloc = ProfileBloc()..add(GetUserDataEvent());
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
            Languages.of(context)!.myProfile,
            style: GoogleFonts.readexPro(
              fontSize: 18.0.sp,
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
              if (state.response != null) {
                if(_userModel == null) {
                  _userModel = state.response!;
                  _nameController.text = _userModel!.data!.name ?? '';
                  _emailController.text = _userModel!.data!.email ?? '';
                }else{
                  Navigator.pop(context, state.response!.data);
                }
              }
            }else if (state is ErrorState && _userModel == null) {
              Navigator.pop(context,);
            }
          },
          child: BlocBuilder<ProfileBloc, GeneralStates>(
              bloc: bloc,
              builder: (context, state) {

                return _userModel == null ? const SizedBox() : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () async {
                              XFile? selectedImage =  await _picker.pickImage(source: ImageSource.gallery);
                              if(selectedImage != null){
                                bloc.add(UpdateUserImageEvent(selectedImage));
                              }
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
                                      child: ClipOval(child:_userModel!.data!.image == null ? Image.asset('assets/logo.png') : imageNetwork(_userModel!.data!.image!)),
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
                        SizedBox(height: 24.h,),
                        filedText(label: '${Languages.of(context)!.name}*', onChange: (s){
                          _stateSetter((){});
                        }, prefix: Icon(CupertinoIcons.building_2_fill, color: AppColors().primaryColor),controller: _nameController, inputType: TextInputType.name, textInputAction: TextInputAction.next, validator: (s){
                          if(s!.isEmpty){
                            return Languages.of(context)!.required;
                          }
                          return null;
                        }),
                        SizedBox(height: 24.h,),
                        filedText(label: Languages.of(context)!.email,  onChange: (s){
                          _stateSetter((){});
                        },prefix: Icon(CupertinoIcons.mail_solid, color: AppColors().primaryColor),controller: _emailController, inputType: TextInputType.name, textInputAction: TextInputAction.next, validator: (s){
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
                                  backgroundColor: MaterialStatePropertyAll(AppColors().primaryColor.withOpacity((_nameController.text != _userModel!.data!.name! || _emailController.text != _userModel!.data!.email! ) ? 1.0 : 0.25) ),
                                  padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 8.h)),
                                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r)
                                  ))
                                ),
                                  onPressed: (_nameController.text != _userModel!.data!.name! || _emailController.text != _userModel!.data!.email! ) ? (){
                                  bloc.add(UpdateUserDataEvent(DataOfUser(
                                    name: _nameController.text,
                                    email: _emailController.text
                                  ).toDataMap()));
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
