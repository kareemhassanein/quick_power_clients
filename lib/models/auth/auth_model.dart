class AuthModel {
  bool? success;
  String? message;
  Data? data;
  Errors? errors;

  AuthModel({this.success, this.message, this.data, this.errors});

  AuthModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (errors != null) {
      data['errors'] = errors!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['token_type'] = tokenType;
    return data;
  }
}

class Errors {
  List<String>? userMobile;
  List<String>? userPassword;
  List<String>? userConfirmPassword;
  List<String>? name;

  Errors({
    this.userMobile,
    this.userPassword,
    this.userConfirmPassword,
    this.name,
  });

  Errors.fromJson(Map<String, dynamic> json) {
    name = json['name']?.cast<String>()!;
    userPassword = json['user_password']?.cast<String>()!;
    userConfirmPassword = json['user_password_confirmation']?.cast<String>()!;
    userMobile = json['user_mobile']?.cast<String>()!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_mobile'] = userMobile;
    data['user_password'] = userPassword;
    data['user_password_confirmation'] = userConfirmPassword;
    data['name'] = name;
    return data;
  }
}
