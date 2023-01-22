// To parse this JSON data, do
//
//     final stationsModel = stationsModelFromJson(jsonString);

import 'dart:convert';

StationsModel stationsModelFromJson(String str) => StationsModel.fromJson(json.decode(str));

String stationsModelToJson(StationsModel data) => json.encode(data.toJson());

class StationsModel {
  StationsModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  dynamic message;
  Data? data;

  factory StationsModel.fromJson(Map<String, dynamic> json) => StationsModel(
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

  List<Station>? data;
  Meta? meta;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data"] == null ? [] : List<Station>.from(json["data"]!.map((x) => Station.fromJson(x))),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "meta": meta?.toJson(),
  };
}

class Station {
  Station({
    this.id,
    this.name,
    this.locationDetails,
    this.lat,
    this.lon,
  });

  int? id;
  String? name;
  String? locationDetails;
  String? lat;
  String? lon;

  factory Station.fromJson(Map<String, dynamic> json) => Station(
    id: json["id"],
    name: json["name"],
    locationDetails: json["location_details"],
    lat: json["lat"],
    lon: json["lon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "location_details": locationDetails,
    "lat": lat,
    "lon": lon,
  };
}

class Meta {
  Meta({
    this.total,
    this.currentPage,
    this.lastPage,
  });

  int? total;
  int? currentPage;
  int? lastPage;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    total: json["total"],
    currentPage: json["currentPage"],
    lastPage: json["lastPage"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "currentPage": currentPage,
    "lastPage": lastPage,
  };
}
