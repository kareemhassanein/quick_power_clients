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
  int? id;
  String? code;
  String? date;
  String? createdAt;
  String? waybillDeliveryExpected;
  String? waybillLoadDate;
  String? waybillTicketNo;
  String? invoiceNo;
  String? driver;
  String? truckCode;
  ProductType? productType;
  Location? location;
  String? customerName;
  ProductType? status;
  String? rate;
  String? url;
  String? transactionId;
  int? total;
  String? quantity;
  String? quantityReceived;
  String? quantityRequired;
  String? itemPrice;
  String? totalPriceItem;
  int? totalVat;
  int? totalFeesLoad;
  int? totalFeesWait;
  int? totalFeesDifference;

  OrderDetails(
      {this.id,
        this.code,
        this.date,
        this.createdAt,
        this.waybillDeliveryExpected,
        this.waybillLoadDate,
        this.waybillTicketNo,
        this.invoiceNo,
        this.driver,
        this.truckCode,
        this.productType,
        this.location,
        this.customerName,
        this.status,
        this.rate,
        this.url,
        this.transactionId,
        this.total,
        this.quantity,
        this.quantityReceived,
        this.quantityRequired,
        this.itemPrice,
        this.totalPriceItem,
        this.totalVat,
        this.totalFeesLoad,
        this.totalFeesWait,
        this.totalFeesDifference});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    date = json['date'];
    createdAt = json['created_at'];
    waybillDeliveryExpected = json['waybill_delivery_expected'];
    waybillLoadDate = json['waybill_load_date'];
    waybillTicketNo = json['waybill_ticket_no'];
    invoiceNo = json['invoice_no'];
    driver = json['driver'];
    truckCode = json['truck_code'];
    productType = json['product_type'] != null
        ? new ProductType.fromJson(json['product_type'])
        : null;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    customerName = json['customer_name'];
    status = json['status'] != null
        ? new ProductType.fromJson(json['status'])
        : null;
    rate = json['rate'];
    url = json['url'];
    transactionId = json['transaction_id'];
    total = json['total'];
    quantity = json['quantity'];
    quantityReceived = json['quantity_received'];
    quantityRequired = json['quantity_required'];
    itemPrice = json['item_price'];
    totalPriceItem = json['total_price_item'];
    totalVat = json['total_vat'];
    totalFeesLoad = json['total_fees_load'];
    totalFeesWait = json['total_fees_wait'];
    totalFeesDifference = json['total_fees_difference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    data['waybill_delivery_expected'] = this.waybillDeliveryExpected;
    data['waybill_load_date'] = this.waybillLoadDate;
    data['waybill_ticket_no'] = this.waybillTicketNo;
    data['invoice_no'] = this.invoiceNo;
    data['driver'] = this.driver;
    data['truck_code'] = this.truckCode;
    if (productType != null) {
      data['product_type'] = productType!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['customer_name'] = customerName;
    if (status != null) {
      data['status'] = status!.toJson();
    }
    data['rate'] = rate;
    data['url'] = this.url;
    data['transaction_id'] = this.transactionId;
    data['total'] = this.total;
    data['quantity'] = this.quantity;
    data['quantity_received'] = this.quantityReceived;
    data['quantity_required'] = this.quantityRequired;
    data['item_price'] = this.itemPrice;
    data['total_price_item'] = this.totalPriceItem;
    data['total_vat'] = this.totalVat;
    data['total_fees'] = this.totalFeesLoad;
    data['total_fees_wait'] = this.totalFeesWait;
    data['total_fees_difference'] = this.totalFeesDifference;
    return data;
  }
}

class ProductType {
  int? id;
  String? name;
  String? address;
  String? lat;
  String? lng;
  String? systemCode;

  ProductType(
      {this.id, this.name, this.address, this.lat, this.lng, this.systemCode});

  ProductType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    systemCode = json['system_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['system_code'] = this.systemCode;
    return data;
  }
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
