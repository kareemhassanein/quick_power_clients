import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:Quick_Power/models/stations_model.dart';
import 'package:Quick_Power/preference.dart';
import '../constrants/apis.dart';
import '../localization/LanguageHelper.dart';
import '../models/auth/auth_model.dart';
import 'package:http/http.dart' as http;

class StationsRepo {
  final Dio dio = Dio();

  Future<StationsModel?> allStations() async {
    var headers = {
      'Accept': 'application/json',
      'app-type': 'CUSTOMER',
      'lang' : LanguageHelper.isEnglish ? 'en' : 'ar',
      'Authorization': 'Bearer ${Preferences.getUserToken()!}'
    };
    var request = http.MultipartRequest('GET', Uri.parse(Apis.getStations));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    StationsModel modelResponse;

    if (response.statusCode == 200) {
      modelResponse = StationsModel.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      modelResponse = StationsModel(message: response.reasonPhrase);
    }

    return modelResponse;
  }

  Future<dynamic> storeStation(Map<String, String> data) async {
    var headers = {
      'Accept': 'application/json',
      'app-type': 'CUSTOMER',
      'lang' : LanguageHelper.isEnglish ? 'en' : 'ar',
      'Authorization': 'Bearer ${Preferences.getUserToken()!}'
    };
    var request = http.MultipartRequest('POST', Uri.parse(Apis.storeStation));

    request.headers.addAll(headers);
    request.fields.addAll(data);

    http.StreamedResponse response = await request.send();
    dynamic  s =  jsonDecode(await response.stream.bytesToString());
    return s;
  }

  Future<dynamic> updateStation({required id, required Map<String, String> data}) async {
    var headers = {
      'Accept': 'application/json',
      'app-type': 'CUSTOMER',
      'lang' : LanguageHelper.isEnglish ? 'en' : 'ar',
      'Authorization': 'Bearer ${Preferences.getUserToken()!}'
    };
    var request = http.MultipartRequest('POST', Uri.parse(Apis.updateStation(id: id)));
    request.headers.addAll(headers);
    request.fields.addAll(data..putIfAbsent('_method', () => 'put'));

    http.StreamedResponse response = await request.send();
    dynamic s = jsonDecode(await response.stream.bytesToString());
    return s;
  }

  static void dioBadRequestAdapter(Dio dio) {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }
}
