// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    this.message,
    this.errors,
  });

  String? message;
  Errors? errors;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    message: json["message"],
    errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": errors?.toJson(),
  };
}

class Errors {
  Errors({
    this.userEmail,
    this.userMobile,
  });

  List<String>? userEmail;
  List<String>? userMobile;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    userEmail: json["user_email"] == null ? [] : List<String>.from(json["user_email"]!.map((x) => x)),
    userMobile: json["user_mobile"] == null ? [] : List<String>.from(json["user_mobile"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "user_email": userEmail == null ? [] : List<dynamic>.from(userEmail!.map((x) => x)),
    "user_mobile": userMobile == null ? [] : List<dynamic>.from(userMobile!.map((x) => x)),
  };
}
