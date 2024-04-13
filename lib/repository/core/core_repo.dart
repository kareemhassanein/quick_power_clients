import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import '../../localization/LanguageHelper.dart';
import '../../preference.dart';

class CoreRepo{

   final Dio dio = Dio();
   CancelToken cancelToken = CancelToken();
   final Options requestOptions = Options(
      responseType: ResponseType.json,
      headers: {
        'Accept': 'application/json',
        'app-type': 'CUSTOMER',
        'Authorization': 'Bearer ${Preferences.getUserToken()!}',
        'lang' : LanguageHelper.isEnglish ? 'en' : 'ar',},
      sendTimeout: const Duration(seconds: 7).inMilliseconds,
      receiveTimeout: const Duration(seconds: 7).inMilliseconds,
      receiveDataWhenStatusError: true,
      validateStatus: (stats) {
        return true;
      });

  Future<Response> post({required String url, data}) async {
    Preferences.cancellationToken.cancel();
    dioBadRequestAdapter(dio);
    late Response response;
    try {
      response = await dio.post(
          url,
          data: data,
          cancelToken: Preferences.cancellationToken,
          options: requestOptions
      );
      return response;
    } on DioError catch (e) {
      String msg = e.message;
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout) {
        msg = 'Make sure you are connected to the network';
      }
      return Response(requestOptions: response.requestOptions, statusCode: 400, statusMessage: msg);
    }
  }

  Future<Response> get({required String url, queryParameters}) async {
   cancelToken.cancel();
    cancelToken = CancelToken();
    dioBadRequestAdapter(dio);
    late Response? response;
    try {
      response = await dio.get<String>(
          url,
          cancelToken: cancelToken,
          options: Options(
              responseType: ResponseType.json,
              headers: {
                'Accept': 'application/json',
                'app-type': 'CUSTOMER',
                'Authorization': 'Bearer ${Preferences.getUserToken()!}',
                'lang' : LanguageHelper.isEnglish ? 'en' : 'ar',},
              sendTimeout: const Duration(seconds: 7).inMilliseconds,
              receiveTimeout: const Duration(seconds: 7).inMilliseconds,
              receiveDataWhenStatusError: true,
              validateStatus: (stats) {
                return true;
              })
      );
      return response;
    } on DioError catch (e) {
      String msg = e.message;
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout) {
        msg = 'Make sure you are connected to the network';
      }
      print(msg);
      return Response(requestOptions: response!.requestOptions, statusCode: 400, statusMessage: msg);
    }
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