// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

OrderDetailsModel orderDetailsModelFromJson(String str) => OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) => json.encode(data.toJson());

class OrderDetailsModel {
  OrderDetailsModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  OrderDetails? data;

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : OrderDetails.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class OrderDetails {
  OrderDetails({
    this.id,
    this.code,
    this.date,
    this.total,
    this.productType,
    this.quantity,
    this.location,
    this.rate,
    this.url,
    this.status,
    this.dateDelivery,
    this.dateRecived,
    this.driver,
    this.inviceNo,
    this.truckInfo
  });

  int? id;
  String? code;
  String? date;
  String? dateRecived;
  String? dateDelivery;
  String? inviceNo;
  String? driver;
  String? truckInfo;
  dynamic total;
  Location? productType;
  Location? status;
  String? quantity;
  Location? location;
  String? rate;
  String? url;

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
    id: json["id"],
    code: json["code"],
    date: json["date"],
    total: json["total"],
    productType: json["product_type"] == null ? null : Location.fromJson(json["product_type"]),
    quantity: json["quantity"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    status: json["status"] == null ? null : Location.fromJson(json["status"]),
    rate: json["rate"],
    url: json["url"],
    truckInfo: json["truck_code"],
    inviceNo: json["invoice_no"],
    driver: json["driver"],
    dateRecived: json["date_recived"],
    dateDelivery: json["date_delivery"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "date": date,
    "total": total,
    "product_type": productType?.toJson(),
    "quantity": quantity,
    "location": location?.toJson(),
    "rate": rate,
    "status": status?.toJson(),
    "url": url,
  };
}

class Location {
  Location({
    this.id,
    this.name,
    this.address,
    this.lat,
    this.lon,
    this.systemCode
  });

  int? id;
  String? name;
  String? address;
  String? lat;
  String? lon;
  String? systemCode;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["id"],
    name: json["name"],
    address: json["location_details"],
    lat: json["lat"],
    lon: json["lon"],
    systemCode: json["system_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
  };
}
