import 'package:bloc_register_login/auth/form_submission_status.dart';
import 'package:bloc_register_login/auth/reg_auth_repository.dart';
import 'package:bloc_register_login/auth/registration/registration_event.dart';
import 'package:bloc_register_login/auth/registration/registration_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState>{

  final RegistrationAuthRepository registrationAuthRepository;

  RegistrationBloc({this.registrationAuthRepository}) : super(RegistrationState());

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if(event is RegistrationFirstNameChanged){
      yield state.copyWith(firstname: event.firstname);

    }else if(event is RegistrationLastNameChanged){
      yield state.copyWith(lastname: event.lastname);

    }else if(event is RegistrationEmailChanged){
      yield state.copyWith(email: event.email);

    }else if(event is RegistrationPasswordChanged){
      yield state.copyWith(password: event.password);

    }else if(event is RegistrationSubmittedButton){
      yield state.copyWith(formStatus: FormSubmitting());

      try{
        await registrationAuthRepository.registration();
        yield state.copyWith(formStatus: SubmissionSuccess());
      }catch (exception) {
        yield state.copyWith(formStatus: SubmissionFailed(exception));
      }
    }
  }
}