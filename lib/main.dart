import 'package:bloc_register_login/auth/auth_repository.dart';
import 'package:bloc_register_login/screens/login.dart';
import 'package:bloc_register_login/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      home: RepositoryProvider(
        create: (context) => AuthRepository(),
        child: Login(),
      ),
      // initialRoute: '/',
      // routes: {
      //   '/' : (context) => Login(),
      //   '/signUpScreen' : (context) => SignUp()
      // },
    );
  }
}
