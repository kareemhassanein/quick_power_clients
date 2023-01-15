class LoginModel {
  bool? success;
  String? message;
  Data? data;
  Errors? errors;


  LoginModel({this.success, this.message, this.data, this.errors});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    errors =
    json['errors'] != null ? Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;
  String? tokenType;

  Data({this.token, this.tokenType});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = token;
    data['token_type'] = tokenType;
    return data;
  }
}

class Errors {
  List<String>? userMobile;
  List<String>? userPassword;

  Errors({this.userMobile, this.userPassword});

  Errors.fromJson(Map<String, dynamic> json) {
    userMobile = json['user_mobile']?.cast<String>()!;
    userPassword = json['user_password']?.cast<String>()!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_mobile'] = userMobile;
    data['user_password'] = userPassword;
    return data;
  }
}
