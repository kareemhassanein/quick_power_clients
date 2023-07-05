import 'dart:convert';

CancelOrderModel postOrderModelFromJson(String str) =>
    CancelOrderModel.fromJson(json.decode(str));

String postOrderModelToJson(CancelOrderModel data) => json.encode(data.toJson());

class CancelOrderModel {
  CancelOrderModel({this.success, this.message,});

  bool? success;
  String? message;

  factory CancelOrderModel.fromJson(Map<String, dynamic> json) => CancelOrderModel(
      success: json["success"],
      message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
