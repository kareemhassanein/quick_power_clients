import 'dart:convert';

PostOrderModel postOrderModelFromJson(String str) =>
    PostOrderModel.fromJson(json.decode(str));

String postOrderModelToJson(PostOrderModel data) => json.encode(data.toJson());

class PostOrderModel {
  PostOrderModel({this.success, this.message, this.data, this.errors});

  bool? success;
  String? message;
  List<dynamic>? data;
  Errors? errors;

  factory PostOrderModel.fromJson(Map<String, dynamic> json) => PostOrderModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<dynamic>.from(json["data"]!.map((x) => x)),
      errors: json['errors'] != null ? Errors.fromJson(json['errors']) : null);

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
      };
}

class Errors {
  List<String>? quantity;
  List<String>? date;
  List<String>? productType;
  List<String>? paymentMethod;
  List<String>? userLocation;

  Errors({
    this.quantity,
    this.date,
    this.productType,
    this.paymentMethod,
    this.userLocation,
  });

  Errors.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity']?.cast<String>()!;
    date = json['date']?.cast<String>()!;
    productType = json['product_type_id']?.cast<String>()!;
    paymentMethod = json['payment_method_id']?.cast<String>()!;
    userLocation = json['user_location_id']?.cast<String>()!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['date'] = date;
    data['product_type_id'] = productType;
    data['payment_method_id'] = paymentMethod;
    data['user_location_id'] = userLocation;
    return data;
  }
}
