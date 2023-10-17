import 'package:image_picker/image_picker.dart';
import 'package:Quick_Power/models/user_model.dart';

abstract class ProfileEvents {}

class GetUserDataEvent extends ProfileEvents {
  GetUserDataEvent();
}

class UpdateUserImageEvent extends ProfileEvents {
  XFile file;
  UpdateUserImageEvent(this.file);
}

class UpdateUserDataEvent extends ProfileEvents {
  Map<String, String> data;
  UpdateUserDataEvent(this.data);
}

class ChangePasswordEvent extends ProfileEvents {
  Map<String, String> data;
  ChangePasswordEvent(this.data);
}


class InitialEvent extends ProfileEvents {}
