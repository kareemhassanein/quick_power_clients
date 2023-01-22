import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import '../constrants/apis.dart';
import '../models/auth/login_model.dart';

class AuthRepo {
  final Dio dio = Dio();
  Future<LoginModel?> login(
      {required String userMobile, required String userPassword}) async {
    dioBadRequestAdapter(dio);
    FormData formData = FormData();
    formData.fields.addAll({
      MapEntry('user_mobile', userMobile),
      MapEntry('user_password', userPassword),
    });
    // formData.files.add(
    //   MapEntry(parameterName,
    //       await MultipartFile.fromFile(file.path)),
    // );
    try {
      Response response = await dio.post<String>(
        Apis.login,
        data: formData,
        options: Options(
            responseType: ResponseType.json,
            headers: {'Accept': 'application/json'},
            sendTimeout: const Duration(seconds: 7).inMilliseconds,
            receiveTimeout: const Duration(seconds: 7).inMilliseconds,
            receiveDataWhenStatusError: true,
            validateStatus: (stats) {
              return true;
            }),
      );
      print(response.data);
      LoginModel modelResponse = LoginModel.fromJson(jsonDecode(response.data));
      return modelResponse;
    } on DioError catch (e) {
      String msg = e.message;
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout) {
        msg = 'Make sure you are connected to the network';
      }
      return LoginModel(message: msg);
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
