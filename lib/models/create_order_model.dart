// To parse this JSON data, do
//
//     final createOrderModel = createOrderModelFromJson(jsonString);

import 'dart:convert';

import 'package:Quick_Power/models/stations_model.dart';

CreateOrderModel createOrderModelFromJson(String str) => CreateOrderModel.fromJson(json.decode(str));

String createOrderModelToJson(CreateOrderModel data) => json.encode(data.toJson());

class CreateOrderModel {
  CreateOrderModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  dynamic message;
  Data? data;

  factory CreateOrderModel.fromJson(Map<String, dynamic> json) => CreateOrderModel(
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
    this.vat,
    this.locations,
    this.paymentMethods,
    this.productTypes,
  });

  double? vat;
  List<Station>? locations;
  List<ProductType>? paymentMethods;
  List<ProductType>? productTypes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    vat:json["vat"] == null ? 0.0 : (json["vat"] is double ? json["vat"] : double.tryParse(json["vat"])??0.0),
    locations: json["locations"] == null ? [] : List<Station>.from(json["locations"]!.map((x) => Station.fromJson(x))),
    paymentMethods: json["payment_methods"] == null ? [] : List<ProductType>.from(json["payment_methods"]!.map((x) => ProductType.fromJson(x))),
    productTypes: json["product_types"] == null ? [] : List<ProductType>.from(json["product_types"]!.map((x) => ProductType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vat": vat,
    "locations": locations == null ? [] : List<dynamic>.from(locations!.map((x) => x.toJson())),
    "payment_methods": paymentMethods == null ? [] : List<dynamic>.from(paymentMethods!.map((x) => x.toJson())),
    "product_types": productTypes == null ? [] : List<dynamic>.from(productTypes!.map((x) => x.toJson())),
  };
}


class ProductType {
  ProductType({
    this.id,
    this.name,
    this.unitPrice,
  });

  int? id;
  String? name;
  num? unitPrice;

  factory ProductType.fromJson(Map<String, dynamic> json) => ProductType(
    id: json["id"],
    name: json["name"],
    unitPrice: json["unit_price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "unit_price": unitPrice,
  };
}
