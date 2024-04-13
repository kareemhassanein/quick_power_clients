import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Quick_Power/bloc/profile/profile_event.dart';
import 'package:Quick_Power/models/user_model.dart';
import 'package:Quick_Power/preference.dart';
import 'package:Quick_Power/repository/profile_repo.dart';

import '../../repository/auth_repo.dart';
import '../../repository/internet_conncection.dart';
import '../general_states.dart';

class ProfileBloc extends Bloc<ProfileEvents, GeneralStates> {
    ProfileBloc() : super(InitialState());
    @override
  Stream<GeneralStates> mapEventToState(
    ProfileEvents event,
  ) async* {
      if (event is GetUserDataEvent) {
        if(await InternetConnection().isConnected()) {
          yield LoadingState();
          UserModel? userModel = await ProfileRepo().getUserData();
          if(userModel != null){
            if(userModel.success != null && !userModel.success!){
              yield ErrorState(msg: userModel.message??'Something Went Wrong!',);
            }else if(userModel.data != null && userModel.success != null && userModel.success!){
              yield SuccessState(msg: userModel.message, response: userModel, showDialog: false);
            }else{
              yield ErrorState(msg: userModel.message??'Something Went Wrong!',);
            }
          }else{
            yield ErrorState(msg: 'Something Went Wrong!',);
          }
        }else{
          yield NoInternetState();
        }
      }else if (event is UpdateUserImageEvent) {
        if(await InternetConnection().isConnected()) {
          yield LoadingState();
          UserModel? userModel = await ProfileRepo().updateUserImage(event.file);
          if(userModel != null){
            if(!userModel.success!){
              yield ErrorState(msg: userModel.message??'Something Went Wrong!',);
            }else if(userModel.data != null && userModel.success!){
              yield SuccessState(msg: userModel.message, response: userModel, showDialog: true);
            }else{
              yield ErrorState(msg: userModel.message??'Something Went Wrong!',);
            }
          }else{
            yield ErrorState(msg: 'Something Went Wrong!',);
          }
        }else{
          yield NoInternetState();
        }
      }else if (event is UpdateUserDataEvent) {
        if(await InternetConnection().isConnected()) {
          yield LoadingState();
          UserModel? userModel = await ProfileRepo().updateUserData(event.data);
          if(userModel != null){
            if(!userModel.success!){
              yield ErrorState(msg: userModel.message??'Something Went Wrong!',);
            }else if(userModel.data != null && userModel.success!){
              yield SuccessState(msg: userModel.message, response: userModel, showDialog: true);
            }else{
              yield ErrorState(msg: userModel.message??'Something Went Wrong!',);
            }
          }else{
            yield ErrorState(msg: 'Something Went Wrong!',);
          }
        }else{
          yield NoInternetState();
        }
      }else if (event is ChangePasswordEvent) {
        if(await InternetConnection().isConnected()) {
          yield LoadingState();
          UserModel? userModel = await ProfileRepo().changePassword(event.data);
          if(userModel != null){
            if(userModel.success != null && !userModel.success!){
              yield ErrorState(msg: userModel.message??'Something Went Wrong!',);
            }else if(userModel.success != null && userModel.success!){
              yield SuccessState(msg: userModel.message, showDialog: true);
            }else{
              yield ErrorState(msg: userModel.message??'Something Went Wrong!',);
            }
          }else{
            yield ErrorState(msg: 'Something Went Wrong!',);
          }
        }else{
          yield NoInternetState();
        }

      }else if (event is ResetPasswordEvent) {
        if(await InternetConnection().isConnected()) {
          yield LoadingState();
          UserModel? userModel = await ProfileRepo().resetPassword(event.data);
          if(userModel != null){
            if(userModel.success != null && !userModel.success!){
              yield ErrorState(msg: userModel.message??'Something Went Wrong!',);
            }else if(userModel.success != null && userModel.success!){
              yield SuccessState(msg: userModel.message, showDialog: true);
            }else{
              yield ErrorState(msg: userModel.message??'Something Went Wrong!',);
            }
          }else{
            yield ErrorState(msg: 'Something Went Wrong!',);
          }
        }else{
          yield NoInternetState();
        }
      }else if (event is InitialEvent) {
        yield InitialState();
      }
  }
  GeneralStates get initialState => InitialState();
}
