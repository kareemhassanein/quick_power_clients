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
    this.availabilityProducts,
    this.customerCreditLimit,
  });

  double? vat;
  dynamic customerCreditLimit;
  List<Station>? locations;
  List<ProductType>? paymentMethods;
  List<ProductType>? productTypes;
  List<AvailabilityProduct>? availabilityProducts;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    customerCreditLimit: json["customer_credit_limit"],
    vat:json["vat"] == null ? 0.0 : (json["vat"] is double ? json["vat"] : double.tryParse(json["vat"])??0.0),
    locations: json["locations"] == null ? [] : List<Station>.from(json["locations"]!.map((x) => Station.fromJson(x))),
    paymentMethods: json["payment_methods"] == null ? [] : List<ProductType>.from(json["payment_methods"]!.map((x) => ProductType.fromJson(x))),
    productTypes: json["product_types"] == null ? [] : List<ProductType>.from(json["product_types"]!.map((x) => ProductType.fromJson(x))),
    availabilityProducts: json["availability_products"] == null ? [] : List<AvailabilityProduct>.from(json["availability_products"]!.map((x) => AvailabilityProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vat": vat,
    "locations": locations == null ? [] : List<dynamic>.from(locations!.map((x) => x.toJson())),
    "payment_methods": paymentMethods == null ? [] : List<dynamic>.from(paymentMethods!.map((x) => x.toJson())),
    "product_types": productTypes == null ? [] : List<dynamic>.from(productTypes!.map((x) => x.toJson())),
    "availability_products": availabilityProducts == null ? [] : List<dynamic>.from(availabilityProducts!.map((x) => x.toJson())),
  };
}


class ProductType {
  ProductType({
    this.id,
    this.name,
    this.unitPrice,
    this.systemCode,
  });

  int? id;
  String? name;
  num? unitPrice;
  String? systemCode;

  factory ProductType.fromJson(Map<String, dynamic> json) => ProductType(
    id: json["id"],
    name: json["name"],
    unitPrice: json["unit_price"],
    systemCode: json["system_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "unit_price": unitPrice,
  };
}

class AvailabilityProduct {
  int? id;
  DateTime? date;
  List<AvailabilityProductsDt>? availabilityProductsDts;

  AvailabilityProduct({
    this.id,
    this.date,
    this.availabilityProductsDts,
  });

  factory AvailabilityProduct.fromJson(Map<String, dynamic> json) => AvailabilityProduct(
    id: json["id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    availabilityProductsDts: json["availability_products_dts"] == null ? [] : List<AvailabilityProductsDt>.from(json["availability_products_dts"]!.map((x) => AvailabilityProductsDt.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "availability_products_dts": availabilityProductsDts == null ? [] : List<dynamic>.from(availabilityProductsDts!.map((x) => x.toJson())),
  };
}

class AvailabilityProductsDt {
  int? id;
  String? quantity;
  String? truckLimit;
  ProductType? product;
  int? remainderQty;
  int? remainderTruck;

  AvailabilityProductsDt({
    this.id,
    this.quantity,
    this.truckLimit,
    this.product,
    this.remainderQty,
    this.remainderTruck,
  });

  factory AvailabilityProductsDt.fromJson(Map<String, dynamic> json) => AvailabilityProductsDt(
    id: json["id"],
    quantity: json["quantity"],
    truckLimit: json["truck_limit"],
    product: json["product"] == null ? null : ProductType.fromJson(json["product"]),
    remainderQty: json["remainder_qty"],
    remainderTruck: json["remainder_truck"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quantity": quantity,
    "truck_limit": truckLimit,
    "product": product?.toJson(),
    "remainder_qty": remainderQty,
    "remainder_truck": remainderTruck,
  };
}