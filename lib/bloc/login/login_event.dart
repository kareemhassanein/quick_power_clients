
abstract class LoginEvents {}

class DoLoginEvent extends LoginEvents {
  late String userEmail;
  late String userPassword;
  DoLoginEvent({required this.userEmail, required this.userPassword});
}
class InitialEvent extends LoginEvents {}
