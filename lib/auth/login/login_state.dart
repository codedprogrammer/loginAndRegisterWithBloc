

import 'package:bloc_register_login/auth/form_submission_status.dart';
import 'package:bloc_register_login/core/error_response.dart';
import 'package:bloc_register_login/core/login_successful.dart';

class LoginState{}

class InitialAccountState extends LoginState {}

class LoadingOn extends LoginState {}

class LoadingOff extends LoginState {}

class LoginFailed extends LoginState {
  final ErrorResponse errorResponse;

  LoginFailed({this.errorResponse});
}

class LoginSuccessState extends LoginState {
  final LoginSuccess loginSuccess;

  LoginSuccessState({this.loginSuccess});
}




