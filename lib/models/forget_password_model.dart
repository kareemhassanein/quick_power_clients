// To parse this JSON data, do
//
//     final sendOtpModel = sendOtpModelFromJson(jsonString);

import 'dart:convert';

import 'package:Quick_Power/models/auth/auth_model.dart';

SendOtpModel sendOtpModelFromJson(String str) => SendOtpModel.fromJson(json.decode(str));

String sendOtpModelToJson(SendOtpModel data) => json.encode(data.toJson());

class SendOtpModel {
  bool? success;
  String? message;
  Data? data;
  Errors? errors;

  SendOtpModel({
    this.success,
    this.message,
    this.data,
    this.errors,
  });

  factory SendOtpModel.fromJson(Map<String, dynamic> json) => SendOtpModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "errors": errors?.toJson(),
  };
}


class Data {
  int? code;

  Data({
    this.code,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
  };
}


