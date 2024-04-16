import 'dart:async';

import 'package:Quick_Power/models/forget_password_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Quick_Power/models/auth/auth_model.dart';
import 'package:Quick_Power/preference.dart';

import '../../repository/auth_repo.dart';
import '../../repository/internet_conncection.dart';
import '../general_states.dart';
import 'login_event.dart';

class AuthBloc extends Bloc<AuthEvents, GeneralStates> {
    AuthBloc() : super(InitialState());
    @override
  Stream<GeneralStates> mapEventToState(
    AuthEvents event,
  ) async* {
      if (event is DoLoginEvent) {
        if(await InternetConnection().isConnected()) {
          yield LoadingState();
          AuthModel? loginModel = await AuthRepo().login(userMobile: event.userEmail, userPassword: event.userPassword);
          if(loginModel != null){
            if(loginModel.errors != null){
              yield ErrorState(msg: loginModel.message??'Something Went Wrong!', errors: loginModel.errors as Errors);
            }else if(loginModel.data != null && loginModel.success!){
              Preferences.setUserToken(loginModel.data!.token!);
              yield SuccessState(msg: loginModel.message, response: loginModel.data, showDialog: true);
            }else{
              yield ErrorState(msg: loginModel.message??'Something Went Wrong!',);
            }
          }else{
            yield ErrorState(msg: 'Something Went Wrong!',);
          }
        }else{
          yield NoInternetState();
        }
      }else if (event is DoRegisterEvent) {
        if(await InternetConnection().isConnected()) {
          yield LoadingState();
          AuthModel? loginModel = await AuthRepo().register(address: event.address, vatNo: event.vatNo,name: event.userName, password: event.userPassword, confirmPassword: event.userConfirmPassword, userId: event.userId,phone: event.userPhone);
          if(loginModel != null){
            if(loginModel.errors != null){
              yield ErrorState(msg: loginModel.message??'Something Went Wrong!', errors: loginModel.errors as Errors);
            }else if(loginModel.data != null && loginModel.success!){
              Preferences.setUserToken(loginModel.data!.token!);
              yield SuccessState(msg: loginModel.message, response: loginModel.data, showDialog: true);
            }else{
              yield ErrorState(msg: loginModel.message??'Something Went Wrong!',);
            }
          }else{
            yield ErrorState(msg: 'Something Went Wrong!',);
          }
        }else{
          yield NoInternetState();
        }
      }else if (event is SendOtpForgetPasswordEvent) {
        if(await InternetConnection().isConnected()) {
          yield LoadingState();
          SendOtpModel? model = await AuthRepo().sendOtpForgetPassword(userMobile: event.userPhone);
          if(model != null){
            if(model.errors != null){
              yield ErrorState(msg: model.message??'Something Went Wrong!', errors: model.errors as Errors);
            }else if(model.data != null && model.success!){
              yield SuccessState(msg: model.message, response: model, showDialog: true);
            }else{
              yield ErrorState(msg: model.message??'Something Went Wrong!',);
            }
          }else{
            yield ErrorState(msg: 'Something Went Wrong!',);
          }
        }else{
          yield NoInternetState();
        }
      }
      else if (event is ResetPasswordEvent) {
        if(await InternetConnection().isConnected()) {
          yield LoadingState();
          SendOtpModel? model = await AuthRepo().sendOtpForgetPassword(userMobile: event.userPhone!);
          if(model != null){
            if(model.errors != null){
              yield ErrorState(msg: model.message??'Something Went Wrong!', errors: model.errors as Errors);
            }else if(model.data != null && model.success!){
              yield SuccessState(msg: model.message, response: model.data, showDialog: true);
            }else{
              yield ErrorState(msg: model.message??'Something Went Wrong!',);
            }
          }else{
            yield ErrorState(msg: 'Something Went Wrong!',);
          }
        }else{
          yield NoInternetState();
        }
      }
      else if (event is InitialEvent) {
        yield InitialState();
      }
  }
  GeneralStates get initialState => InitialState();
}
