import 'package:bloc_register_login/auth/auth_repository.dart';
import 'package:bloc_register_login/auth/form_submission_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_register_login/auth/login/login_event.dart';
import 'package:bloc_register_login/auth/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{

  final AuthRepository authRepository;

  LoginBloc({this.authRepository}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if(event is LoginUsernameChanged){
      yield state.copyWith(username: event.username);

    }else if(event is LoginPasswordChanged){
      yield state.copyWith(password: event.password);

    }else if(event is LoginSubmittedButton){
      yield state.copyWith(formStatus: FormSubmitting());

      try{
        await authRepository.login();
        yield state.copyWith(formStatus: SubmissionSuccess());
      }catch (exception) {
        yield state.copyWith(formStatus: SubmissionFailed(exception));
      }

    }
  }
}