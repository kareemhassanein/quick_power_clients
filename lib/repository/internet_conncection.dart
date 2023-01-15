import 'package:connectivity_plus/connectivity_plus.dart';


class InternetConnection{
  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      return Future.value(true);
    }else{
      return Future.value(false);
    }
  }
}
