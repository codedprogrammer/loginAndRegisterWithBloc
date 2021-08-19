class RegistrationAuthRepository{
  Future<void> registration() async {
    print('attempting registration');
    await Future.delayed(Duration(seconds: 5));
    print('registered');
    throw Exception('registrationfailed');
  }
}