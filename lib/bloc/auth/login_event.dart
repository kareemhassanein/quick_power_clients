
abstract class AuthEvents {}

class DoLoginEvent extends AuthEvents {
  late String userEmail;
  late String userPassword;
  DoLoginEvent({required this.userEmail, required this.userPassword});
}

class DoRegisterEvent extends AuthEvents {
  late String userName;
  late String userPhone;
  late String userId;
  late String userPassword;
  late String userConfirmPassword;
  DoRegisterEvent({required this.userName, required this.userPhone, required this.userId, required this.userPassword, required this.userConfirmPassword,});
}
class InitialEvent extends AuthEvents {}
