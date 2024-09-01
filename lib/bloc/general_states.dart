import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

abstract class GeneralStates {
  GeneralStates();
}

class InitialState extends GeneralStates {
  InitialState() {
    EasyLoading.dismiss();
  }
}

class LoadingState extends GeneralStates {
  LoadingState({String? msg, bool showDialog = true}) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (showDialog) {
      EasyLoading.show(
        status: msg,
      );
    }
  }
}

class SuccessState extends GeneralStates {
  dynamic response;
  String? type;

  SuccessState({String? msg, this.response, bool showDialog = false, this.type}) {
    if (showDialog) {
      EasyLoading.showSuccess(msg ?? '', dismissOnTap: true);
    } else {
      EasyLoading.dismiss();
    }
  }
}

class ErrorState extends GeneralStates {
  dynamic errors;
  dynamic msg;

  ErrorState({this.msg, this.errors}) {
    EasyLoading.showError(msg ?? '', dismissOnTap: true);
  }
}

class NoInternetState extends GeneralStates {
  NoInternetState() : super();
}
