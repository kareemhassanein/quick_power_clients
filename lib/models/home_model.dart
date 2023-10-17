// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

import 'package:Quick_Power/models/order_details_model.dart';
import 'package:Quick_Power/models/user_model.dart';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
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
    this.pagination,
    this.done,
    this.progress,
    this.pending,
    this.user,
  });

  PaginationHome? pagination;
  List<OrderDetails>? done;
  List<OrderDetails>? progress;
  List<OrderDetails>? pending;
  DataOfUser? user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pagination: json["meta"] == null ? null : PaginationHome.fromJson(json["meta"]),
    done: json["done"] == null ? [] : List<OrderDetails>.from(json["done"]!.map((x) => OrderDetails.fromJson(x))),
    progress: json["progress"] == null ? [] : List<OrderDetails>.from(json["progress"]!.map((x) => OrderDetails.fromJson(x))),
    pending: json["pending"] == null ? [] : List<OrderDetails>.from(json["pending"]!.map((x) => OrderDetails.fromJson(x))),
    user: json["user"] == null ? null : DataOfUser.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "meta": pagination?.toJson(),
    "done": done == null ? [] : List<dynamic>.from(done!.map((x) => x)),
    "progress": progress == null ? [] : List<dynamic>.from(progress!.map((x) => x)),
    "pending": pending == null ? [] : List<dynamic>.from(pending!.map((x) => x.toJson())),
    "user": user?.toJson(),
  };
}

class PaginationHome {
  PaginationHome({
    this.totalDone,
    this.totalProgress,
    this.totalPending,
    this.perPage,
  });

  int? totalDone;
  int? totalProgress;
  int? totalPending;
  int? perPage;

  factory PaginationHome.fromJson(Map<String, dynamic> json) => PaginationHome(
    totalDone: json["total_done"],
    totalProgress: json["total_progress"],
    totalPending: json["total_pending"],
    perPage: json["per_page"],
  );

  Map<String, dynamic> toJson() => {
    "total_done": totalDone,
    "total_progress": totalProgress,
    "total_pending": totalPending,
    "per_page": perPage,
  };
}
