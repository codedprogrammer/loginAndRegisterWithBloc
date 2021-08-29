
import 'package:bloc_register_login/model/login.dart';

abstract class LoginEvent{}


class LoginUser extends LoginEvent {
  final Login login;
  LoginUser({this.login});
}


