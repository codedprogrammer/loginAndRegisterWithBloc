import 'package:bloc_register_login/screens/login.dart';
import 'package:bloc_register_login/screens/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => Login(),
        '/signUpScreen' : (context) => SignUp()
      },
    );
  }
}
