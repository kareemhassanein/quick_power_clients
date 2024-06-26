import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  DataOfUser? data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null || json["data"] is List ? null : DataOfUser.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class DataOfUser {
  DataOfUser({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.status,
    this.createdAt,
    this.userId,
    this.vatNo,
    this.address
  });

  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? status;
  String? userId;
  String? vatNo;
  String? address;
  DateTime? createdAt;

  factory DataOfUser.fromJson(Map<String, dynamic> json) => DataOfUser(
    id: json["id"],
    name: json["name"],
    email: json["email"]??'',
    phone: json["phone"],
    image: json["image"],
    status: json["status"],
    address: json["user_address"],
    userId: json["user_identity"],
    vatNo: json["vat"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "image": image,
    "status": status,
    "user_address": address,
    "created_at": createdAt?.toIso8601String(),
  };

  Map<String, String> toDataMap() => {
    "name": name.toString(),
    "user_email": email.toString(),
    "user_address": address.toString(),
    "vat": vatNo.toString(),
    "user_identity": userId.toString(),
  };
}
