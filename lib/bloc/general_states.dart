import 'package:flutter_easyloading/flutter_easyloading.dart';

abstract class GeneralStates {
  GeneralStates();
}

class InitialState extends GeneralStates {
  InitialState(){
    EasyLoading.dismiss();
  }}

class LoadingState extends GeneralStates {
  LoadingState({String? msg}){
    EasyLoading.show(status: msg);
  }
}

class SuccessState extends GeneralStates {
  dynamic response;
  SuccessState({String? msg, this.response}){
    EasyLoading.showSuccess(msg??'');
  }}

class ErrorState extends GeneralStates {
  dynamic errors;
  ErrorState({String? msg, this.errors}){
    EasyLoading.showError(msg??'');
  }}


class NoInternetState extends GeneralStates {
  NoInternetState() : super();
}
