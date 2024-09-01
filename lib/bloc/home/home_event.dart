import 'package:image_picker/image_picker.dart';
import 'package:Quick_Power/models/user_model.dart';

abstract class HomeEvents {}

class GetHomeAllEvent extends HomeEvents {
  bool refresh = true;
  GetHomeAllEvent({this.refresh = true});
}

class GetOrdersPaginationEvent extends HomeEvents {
  int type;
  int page;
  GetOrdersPaginationEvent({required this.type,required this.page});
}

class GetCreateOrderEvent extends HomeEvents {
  GetCreateOrderEvent();
}

class GetOrderDetailsEvent extends HomeEvents {
  String id;
  GetOrderDetailsEvent({required this.id});
}

class StoreOrderEvent extends HomeEvents {
  Map<String, String> data;
  StoreOrderEvent({required this.data});
}

class CancelOrderEvent extends HomeEvents {
  String id;
  CancelOrderEvent({required this.id});
}


class GetTermsEvent extends HomeEvents {
  GetTermsEvent();
}

class GetQsEvent extends HomeEvents {
  GetQsEvent();
}


class InitialEvent extends HomeEvents {}
