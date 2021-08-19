import 'package:bloc_register_login/auth/form_submission_status.dart';

class RegistrationState{
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final FormSubmissionStatus formStatus;

  RegistrationState( {
    this.firstname = '', 
    this.lastname = '', 
    this.email = '', 
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  }); 

  RegistrationState copyWith({
    String firstname,
    String lastname,
    String email,
    String password,
    FormSubmissionStatus formStatus,
  }){
    return RegistrationState(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}