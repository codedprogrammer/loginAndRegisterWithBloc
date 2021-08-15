import 'package:bloc_register_login/auth/login/login_event.dart';
import 'package:bloc_register_login/auth/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  LoginBloc() : super(LoginState());
}