import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:Quick_Power/models/user_model.dart';

import '../constrants/apis.dart';
import '../localization/LanguageHelper.dart';
import '../preference.dart';

class ProfileRepo {

  Future<UserModel?> getUserData() async {
    var headers = {
      'Accept': 'application/json',
      'app-type': 'CUSTOMER',
      'lang' : LanguageHelper.isEnglish ? 'en' : 'ar',
      'Authorization': 'Bearer ${Preferences.getUserToken()!}'
    };
    var request = http.MultipartRequest('GET', Uri.parse(Apis.showProfile));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    UserModel modelResponse;

    if (response.statusCode == 200) {
      modelResponse = UserModel.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      modelResponse = UserModel(message: response.reasonPhrase);
    }

    return modelResponse;
  }

  Future<UserModel?> updateUserImage(XFile file) async {
    var headers = {
      'Accept': 'application/json',
      'app-type': 'CUSTOMER',
      'lang' : LanguageHelper.isEnglish ? 'en' : 'ar',
      'Authorization': 'Bearer ${Preferences.getUserToken()!}'
    };
    var request = http.MultipartRequest('POST', Uri.parse(Apis.changeUserImage));
    request.files.add(await http.MultipartFile.fromPath('image', file.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    UserModel modelResponse;

    if (response.statusCode == 200) {
      modelResponse = UserModel.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      modelResponse = UserModel(message: response.reasonPhrase);
    }

    return modelResponse;
  }

 Future<UserModel?> updateUserData(Map<String, String> data) async {
    var headers = {
      'Accept': 'application/json',
      'app-type': 'CUSTOMER',
      'lang' : LanguageHelper.isEnglish ? 'en' : 'ar',
      'Authorization': 'Bearer ${Preferences.getUserToken()!}'
    };
    var request = http.MultipartRequest('POST', Uri.parse(Apis.changeUserData));
    request.fields.addAll(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    UserModel modelResponse;

    if (response.statusCode == 200) {
      modelResponse = UserModel.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      modelResponse = UserModel(message: response.reasonPhrase);
    }

    return modelResponse;
  }

 Future<UserModel?> changePassword(Map<String, String> data) async {
    var headers = {
      'Accept': 'application/json',
      'app-type': 'CUSTOMER',
      'lang' : LanguageHelper.isEnglish ? 'en' : 'ar',
      'Authorization': 'Bearer ${Preferences.getUserToken()!}'
    };
    var request = http.MultipartRequest('POST', Uri.parse(Apis.changePassword));
    request.fields.addAll(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    UserModel modelResponse;

    if (response.statusCode == 200) {
      modelResponse = UserModel.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      modelResponse = UserModel(message: response.reasonPhrase);
    }

    return modelResponse;
  }

 Future<UserModel?> resetPassword(Map<String, String> data) async {
    var headers = {
      'Accept': 'application/json',
      'app-type': 'CUSTOMER',
      'lang' : LanguageHelper.isEnglish ? 'en' : 'ar',
    };
    var request = http.MultipartRequest('POST', Uri.parse(Apis.resetPassword));
    request.fields.addAll(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    UserModel modelResponse;

    if (response.statusCode == 200) {
      modelResponse = UserModel.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      modelResponse = UserModel(message: response.reasonPhrase);
    }

    return modelResponse;
  }

  // Future<dynamic> editProfile(Map<String, String> data) async {
  //   var headers = {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer ${Preferences.getUserToken()!}'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse(Apis.storeStation));
  //
  //   request.headers.addAll(headers);
  //   request.fields.addAll(data);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     return jsonDecode(await response.stream.bytesToString());
  //   } else {
  //     jsonEncode({
  //       'success': false,
  //       'message': response.reasonPhrase,
  //     });
  //   }
  // }

}
