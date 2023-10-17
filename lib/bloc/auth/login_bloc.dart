import 'dart:async';

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
          AuthModel? loginModel = await AuthRepo().register(name: event.userName, password: event.userPassword, confirmPassword: event.userConfirmPassword, userId: event.userId,phone: event.userPhone);
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
      }else if (event is InitialEvent) {
        yield InitialState();
      }
  }
  GeneralStates get initialState => InitialState();
}
