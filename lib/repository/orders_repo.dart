import 'dart:convert';

import 'package:Quick_Power/models/driver_location.dart';
import 'package:Quick_Power/models/notifications_model.dart';
import 'package:dio/dio.dart';
import 'package:Quick_Power/localization/LanguageHelper.dart';
import 'package:Quick_Power/models/cancel_order_model.dart';
import 'package:Quick_Power/models/create_order_model.dart';
import 'package:Quick_Power/models/home_model.dart';
import 'package:http/http.dart' as http;
import 'package:Quick_Power/models/order_details_model.dart';
import 'package:Quick_Power/models/orders_pagination_model.dart';
import 'package:Quick_Power/models/post_order_model.dart';
import 'package:Quick_Power/repository/core/core_repo.dart';
import '../constrants/apis.dart';
import '../preference.dart';

class OrdersRepo{

  Future<HomeModel?> getHomeAll() async {

    HomeModel modelResponse;
    Response response = await CoreRepo().get(url: Apis.homeAll);
    print(response.data);
    if (response.statusCode == 200) {
      modelResponse = HomeModel.fromJson(
          jsonDecode(response.data));
    } else {
      modelResponse = HomeModel(message: response.statusMessage, success: false);
    }

    return modelResponse;
  }

  Future<OrdersPaginationModel?> getOrdersPagination({required type, required page}) async {

    Response response = await CoreRepo().get(url: Apis.homePagination(type: type.toString(), page: page.toString()));

    OrdersPaginationModel modelResponse;

    if (response.statusCode == 200) {
      modelResponse = OrdersPaginationModel.fromJson(
          jsonDecode(response.data));
    } else {
      modelResponse = OrdersPaginationModel(message: response.statusMessage, success: false);
    }

    return modelResponse;
  }

  Future<OrderDetailsModel?> getOrderDetails({required id}) async {

    Response response = await CoreRepo().get(url: Apis.orderDetails(id: id));
    print(response.data);

    OrderDetailsModel modelResponse;

    if (response.statusCode == 200) {
      modelResponse = OrderDetailsModel.fromJson(
          jsonDecode(response.data));
    } else {
      modelResponse = OrderDetailsModel(message: response.statusMessage, success: false);
    }
    return modelResponse;
  }

  Future<CreateOrderModel?> getCreateOrder() async {
    var headers = {
      'Accept': 'application/json',
      'app-type': 'CUSTOMER',
      'lang': LanguageHelper.isEnglish ? 'en' : 'ar',
      'Authorization': 'Bearer ${Preferences.getUserToken()!}'
    };
    var request = http.MultipartRequest('GET', Uri.parse(Apis.createOrder));

    request.headers.addAll(headers);

      final response = await request.send().timeout(const Duration(seconds: 12));

      CreateOrderModel modelResponse;
      modelResponse =
          CreateOrderModel.fromJson(jsonDecode(await response.stream.bytesToString()));
      return modelResponse;

  }

  Future<NotificationModel?> getNotificationsList() async {
    var headers = {
      'Accept': 'application/json',
      'app-type': 'CUSTOMER',
      'lang': LanguageHelper.isEnglish ? 'en' : 'ar',
      'Authorization': 'Bearer ${Preferences.getUserToken()!}'
    };
    var request = http.MultipartRequest('GET', Uri.parse(Apis.notificationsList));

    request.headers.addAll(headers);

    final response = await request.send().timeout(const Duration(seconds: 60));

    NotificationModel modelResponse;
      modelResponse =
          NotificationModel.fromJson(jsonDecode(await response.stream.bytesToString()));
      return modelResponse;
  }

  Future<Future<String?>> seenAllNotifications() async {
    var headers = {
      'Accept': 'application/json',
      'app-type': 'CUSTOMER',
      'lang': LanguageHelper.isEnglish ? 'en' : 'ar',
      'Authorization': 'Bearer ${Preferences.getUserToken()!}'
    };
    var request = http.MultipartRequest('POST', Uri.parse(Apis.readAllNotifications));

    request.headers.addAll(headers);

    final response = await request.send().timeout(const Duration(seconds: 60));
      return response.stream.bytesToString();
  }



  Future<Future<String?>> updateFCMToken(String token) async {
    var headers = {
      'Accept': 'application/json',
      'app-type': 'CUSTOMER',
      'lang': LanguageHelper.isEnglish ? 'en' : 'ar',
      'Authorization': 'Bearer ${Preferences.getUserToken()!}'
    };
    var request = http.MultipartRequest('POST', Uri.parse(Apis.updateFCMToken));
    request.fields.addAll({'user_token' : token});

    request.headers.addAll(headers);

    final response = await request.send().timeout(const Duration(seconds: 60));
      return response.stream.bytesToString();
  }



  Future<PostOrderModel?> storeOrder({required data}) async {
    var headers = {
      'Accept': 'application/json',
      'app-type': 'CUSTOMER',
      'Authorization': 'Bearer ${Preferences.getUserToken()!}'
    };
    var request = http.MultipartRequest('POST', Uri.parse(Apis.storeOrder));
    request.fields.addAll(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    // print(await response.stream.bytesToString());
    PostOrderModel modelResponse;

    if (response.statusCode == 200) {
      modelResponse = PostOrderModel.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      modelResponse = PostOrderModel(message: response.reasonPhrase, success: false);
    }
    print(modelResponse.toJson().toString());

    return modelResponse;
  }

  Future<CancelOrderModel?> cancelOrder({required id}) async {
    var headers = {
      'Accept': 'application/json',
      'app-type': 'CUSTOMER',
      'lang' : LanguageHelper.isEnglish ? 'en' : 'ar',
      'Authorization': 'Bearer ${Preferences.getUserToken()!}'
    };
    var request = http.MultipartRequest('POST', Uri.parse(Apis.cancelOrder(id: id)));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    CancelOrderModel modelResponse;

    if (response.statusCode == 200) {
      modelResponse = CancelOrderModel.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      modelResponse = CancelOrderModel(message: response.reasonPhrase);
    }

    return modelResponse;
  }


  Future<DriverLocation?> getriverLocation(String orderId) async {
    var headers = {
      'Accept': 'application/json',
      'app-type': 'CUSTOMER',
      'lang' : LanguageHelper.isEnglish ? 'en' : 'ar',
      'Authorization': 'Bearer ${Preferences.getUserToken()!}'
    };
    var request = http.MultipartRequest('GET', Uri.parse(Apis.getDriverLocation(id: orderId)));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    DriverLocation modelResponse;


      modelResponse = DriverLocation.fromJson(
          jsonDecode(await response.stream.bytesToString()));

    return modelResponse;
  }

}