// To parse this JSON data, do
//
//     final ordersPaginationModel = ordersPaginationModelFromJson(jsonString);

import 'dart:convert';

import 'package:Quick_Power/models/order_details_model.dart';

OrdersPaginationModel ordersPaginationModelFromJson(String str) => OrdersPaginationModel.fromJson(json.decode(str));

String ordersPaginationModelToJson(OrdersPaginationModel data) => json.encode(data.toJson());

class OrdersPaginationModel {
  OrdersPaginationModel({
    this.success,
    this.message,
    this.data,
    this.type
  });

  bool? success;
  String? message;
  Data? data;
  int? type;

  factory OrdersPaginationModel.fromJson(Map<String, dynamic> json) => OrdersPaginationModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.data,
    this.meta,
  });

  List<OrderDetails>? data;
  Meta? meta;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data"] == null ? [] : List<OrderDetails>.from(json["data"]!.map((x) => OrderDetails.fromJson(x))),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "meta": meta?.toJson(),
  };
}

class Meta {
  Meta({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
  });

  int? total;
  int? perPage;
  String? currentPage;
  int? lastPage;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    total: json["total"],
    perPage: json["per_page"],
    currentPage: json["currentPage"],
    lastPage: json["lastPage"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "per_page": perPage,
    "currentPage": currentPage,
    "lastPage": lastPage,
  };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.status,
    this.createdAt,
    this.parent,
  });

  int? id;
  String? name;
  dynamic email;
  String? phone;
  dynamic image;
  String? status;
  DateTime? createdAt;
  User? parent;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    image: json["image"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    parent: json["parent"] == null ? null : User.fromJson(json["parent"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "image": image,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "parent": parent?.toJson(),
  };
}
