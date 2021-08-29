import 'package:bloc_register_login/auth/auth_repository.dart';
import 'package:bloc_register_login/auth/form_submission_status.dart';
import 'package:bloc_register_login/core/error_response.dart';
import 'package:bloc_register_login/core/login_successful.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_register_login/auth/login/login_event.dart';
import 'package:bloc_register_login/auth/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(AuthRepository authRepository) : super(InitialAccountState());
  

  AuthRepository _authRepo = AuthRepository();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUser) {
      yield* _login(event);
    }
  }

    Stream<LoginState> _login(LoginUser event) async* {
    yield LoadingOn();
    try {
      var response = await _authRepo.loginUser(login: event.login);
      if (response is LoginSuccess) {
        yield LoadingOff();
        yield LoginSuccessState(loginSuccess: response);
      } else if (response is ErrorResponse) {
        yield LoadingOff();
        yield LoginFailed(errorResponse: response);
      } else {
        yield LoadingOff();
        yield LoginFailed(errorResponse: response);
      }
    } catch (ex) {
      if (ex != 'cancel') {
        var errorMsg = ErrorResponse(error: ex.toString());
        yield LoadingOff();
        yield LoginFailed(errorResponse: errorMsg);
      }
    }
  }

}
