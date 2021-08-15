class AuthRepository{
  Future<void> login() async {
    print('attempting login');
    await Future.delayed(Duration(seconds: 5));
    print('logged in');
  }
}