
abstract class AuthEvents {}

class DoLoginEvent extends AuthEvents {
  late String userEmail;
  late String userPassword;
  DoLoginEvent({required this.userEmail, required this.userPassword});
}

class SendOtpForgetPasswordEvent extends AuthEvents {
  late String userPhone;
  SendOtpForgetPasswordEvent({required this.userPhone,});
}

class ResetPasswordEvent extends AuthEvents {
  late String userOtp;
  late String password;
  late String? userPhone;
  late String confirmPassword;
  ResetPasswordEvent({required this.userOtp, required this.password, required this.confirmPassword});
}

class DoRegisterEvent extends AuthEvents {
  late String userName;
  late String userPhone;
  late String userId;
  late String vatNo;
  late String address;
  late String userPassword;
  late String userConfirmPassword;
  DoRegisterEvent({required this.userName, required this.userPhone, required this.userId, required this.userPassword, required this.userConfirmPassword, required this.vatNo, required this.address});
}
class InitialEvent extends AuthEvents {}
