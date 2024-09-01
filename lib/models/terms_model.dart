// To parse this JSON data, do
//
//     final termsModel = termsModelFromJson(jsonString);

import 'dart:convert';

TermsModel termsModelFromJson(String str) => TermsModel.fromJson(json.decode(str));

String termsModelToJson(TermsModel data) => json.encode(data.toJson());

class TermsModel {
  bool? success;
  dynamic message;
  List<Datum>? data;

  TermsModel({
    this.success,
    this.message,
    this.data,
  });

  factory TermsModel.fromJson(Map<String, dynamic> json) => TermsModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? url;
  String? text;

  Datum({
    this.id,
    this.url,
    this.text,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    url: json["url"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "text": text,
  };
}
