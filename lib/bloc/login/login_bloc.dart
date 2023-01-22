import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waqoodi_client/models/auth/login_model.dart';
import 'package:waqoodi_client/preference.dart';

import '../../repository/auth_repo.dart';
import '../../repository/internet_conncection.dart';
import '../general_states.dart';
import 'login_event.dart';

class LoginBloc extends Bloc<LoginEvents, GeneralStates> {
  LoginBloc() : super(InitialState());
  @override
  Stream<GeneralStates> mapEventToState(
    LoginEvents event,
  ) async* {
      if (event is DoLoginEvent) {
        if(await InternetConnection().isConnected()) {
          yield LoadingState();
          LoginModel? loginModel = await AuthRepo().login(userMobile: event.userEmail, userPassword: event.userPassword);
          if(loginModel != null){
            if(loginModel.errors != null){
              yield ErrorState(msg: loginModel.message??'Something Went Wrong!', errors: loginModel.errors as Errors);
            }else if(loginModel.data != null && loginModel.success!){
              await Preferences.setUserToken(loginModel.data!.token!);
              yield SuccessState(msg: loginModel.message, response: loginModel.data);
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
