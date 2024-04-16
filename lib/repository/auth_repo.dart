import 'dart:convert';
import 'dart:io';
import 'package:Quick_Power/models/forget_password_model.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:Quick_Power/preference.dart';
import '../constrants/apis.dart';
import '../localization/LanguageHelper.dart';
import '../models/auth/auth_model.dart';

class AuthRepo {
  final Dio dio = Dio();
  final Options requestOptions = Options(
      responseType: ResponseType.json,
      headers: {'Accept': 'application/json',
        'app-type': 'CUSTOMER',
        'lang' : LanguageHelper.isEnglish ? 'en' : 'ar',},
      sendTimeout: const Duration(seconds: 7).inMilliseconds,
      receiveTimeout: const Duration(seconds: 7).inMilliseconds,
      receiveDataWhenStatusError: true,
      validateStatus: (stats) {
        return true;
      });

  Future<AuthModel?> login(
      {required String userMobile, required String userPassword}) async {
    dioBadRequestAdapter(dio);
    FormData formData = FormData();
    formData.fields.addAll({
      MapEntry('user_mobile', userMobile),
      MapEntry('user_password', userPassword),
      const MapEntry('type', '1'),
    });
    try {
      Response response = await dio.post<String>(
        Apis.login,
        data: formData,
        options: Options(
            responseType: ResponseType.json,
            headers: {
              'Accept': 'application/json',
              'app-type': 'CUSTOMER',
              'lang' : LanguageHelper.isEnglish ? 'en' : 'ar',},
            sendTimeout: const Duration(seconds: 7).inMilliseconds,
            receiveTimeout: const Duration(seconds: 7).inMilliseconds,
            receiveDataWhenStatusError: true,
            validateStatus: (stats) {
              return true;
            }),
      );
      print(response.data);
      AuthModel modelResponse = AuthModel.fromJson(jsonDecode(response.data));
      return modelResponse;
    } on DioError catch (e) {
      String msg = e.message;
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout) {
        msg = 'Make sure you are connected to the network';
      }
      return AuthModel(message: msg);
    }
  }

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
    Preferences.cancellationToken.cancel();
    dioBadRequestAdapter(dio);
    late Response response;
    try {
       response = await dio.get(
        url,
        queryParameters: queryParameters,
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

  Future<AuthModel?> register(
      {required String name, required String phone, required String userId, required String password, required String confirmPassword, required String vatNo, required String address}) async {
    dioBadRequestAdapter(dio);
    FormData formData = FormData();
    formData.fields.addAll({
      MapEntry('name', name),
      MapEntry('user_password', password),
      MapEntry('user_password_confirmation', confirmPassword),
      MapEntry('user_mobile', phone),
      MapEntry('user_identity', userId),
      MapEntry('vat', vatNo),
      MapEntry('user_address', address),
      const MapEntry('type', '1'),
    });
    // formData.files.add(
    //   MapEntry(parameterName,
    //       await MultipartFile.fromFile(file.path)),
    // );
    try {
      CancelToken cancelToken=CancelToken();
      Response response = await dio.post<String>(
        Apis.signUp,
        data: formData,
        cancelToken: cancelToken,
        options: Options(
            responseType: ResponseType.json,
            headers: {'Accept': 'application/json',
              'app-type': 'CUSTOMER',
              'lang' : LanguageHelper.isEnglish ? 'en' : 'ar',
            },
            sendTimeout: const Duration(seconds: 7).inMilliseconds,
            receiveTimeout: const Duration(seconds: 7).inMilliseconds,
            receiveDataWhenStatusError: true,
            validateStatus: (stats) {
              return true;
            }),
      );
      print(response.data);
      AuthModel modelResponse = AuthModel.fromJson(jsonDecode(response.data));
      return modelResponse;
    } on DioError catch (e) {
      String msg = e.message;
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout) {
        msg = 'Make sure you are connected to the network';
      }
      return AuthModel(message: msg);
    }
  }


  Future<SendOtpModel?> sendOtpForgetPassword(
      {required String userMobile, }) async {
    dioBadRequestAdapter(dio);
    FormData formData = FormData();
    formData.fields.addAll({
      MapEntry('user_mobile', userMobile),
      const MapEntry('type', '1'),
    });
    try {
      Response response = await dio.post<String>(
        Apis.sendOtpforgetPassword,
        data: formData,
        options: Options(
            responseType: ResponseType.json,
            headers: {'Accept': 'application/json',
              'app-type': 'CUSTOMER',
              'lang' : LanguageHelper.isEnglish ? 'en' : 'ar',},

            receiveDataWhenStatusError: true,
            validateStatus: (stats) {
              return true;
            }),
      );
      SendOtpModel modelResponse = SendOtpModel.fromJson(jsonDecode(response.data));
      return modelResponse;
    } on DioError catch (e) {
      String msg = e.message??'';
      if (e.type == DioErrorType.sendTimeout) {
        msg = 'Make sure you are connected to the network';
      }
      return SendOtpModel(message: msg);
    }
  }

  Future<SendOtpModel?> resetPassword(
      {required String userOtp, required String password, required String passwordConfirmation, }) async {
    dioBadRequestAdapter(dio);
    FormData formData = FormData();
    formData.fields.addAll({
      MapEntry('user_otp', userOtp),
      MapEntry('password', password),
      MapEntry('password_confirmation', passwordConfirmation),
      const MapEntry('type', '1'),
    });
    try {
      Response response = await dio.post<String>(
        Apis.resetPassword,
        data: formData,
        options: Options(
            responseType: ResponseType.json,
            headers: {'Accept': 'application/json',
              'app-type': 'CUSTOMER',
              'lang' : LanguageHelper.isEnglish ? 'en' : 'ar',},

            receiveDataWhenStatusError: true,
            validateStatus: (stats) {
              return true;
            }),
      );
      SendOtpModel modelResponse = SendOtpModel.fromJson(jsonDecode(response.data));
      return modelResponse;
    } on DioError catch (e) {
      String msg = e.message??'';
      if (
          e.type == DioErrorType.sendTimeout) {
        msg = 'Make sure you are connected to the network';
      }
      return SendOtpModel(message: msg);
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
