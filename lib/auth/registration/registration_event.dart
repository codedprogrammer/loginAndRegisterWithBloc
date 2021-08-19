abstract class RegistrationEvent{}

class RegistrationFirstNameChanged extends RegistrationEvent{
  final String firstname;

  RegistrationFirstNameChanged({this.firstname});
}

class RegistrationLastNameChanged extends RegistrationEvent{
  final String lastname;

  RegistrationLastNameChanged(this.lastname);
}

class RegistrationEmailChanged extends RegistrationEvent{
  final String email;

  RegistrationEmailChanged(this.email);
}

class RegistrationPasswordChanged extends RegistrationEvent{
  final String password;

  RegistrationPasswordChanged({this.password});
}

class RegistrationSubmittedButton extends RegistrationEvent{}

