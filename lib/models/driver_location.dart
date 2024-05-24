import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverLocation {
  final bool? success;
  final String? message;
  final Data? data;
  final int? code;

  DriverLocation({this.success, this.message, this.data, this.code});

  factory DriverLocation.fromJson(Map<String, dynamic> json) {
    return DriverLocation(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      code: json['code'],
    );
  }

  factory DriverLocation.fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return DriverLocation.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
      'code': code,
    };
  }
}

class Data {
  final LatLng? driverLocation;

  Data({this.driverLocation});

  factory Data.fromJson(Map<String, dynamic> json) {
    String? locationString = json['driver_location'];
    print('dddddddddddd   ${locationString}');
    List<String>? parts = locationString?.split(',');
    double? lat = double.tryParse(parts?[0] ?? '');
    double? lng = double.tryParse(parts?[1] ?? '');
    LatLng? driverLocation;
    if (lat != null && lng != null) {
      driverLocation = LatLng(lat, lng);
    }
    return Data(driverLocation: driverLocation);
  }

  Map<String, dynamic> toJson() {
    return {
      'driver_location': '${driverLocation?.latitude},${driverLocation?.longitude}',
    };
  }
}