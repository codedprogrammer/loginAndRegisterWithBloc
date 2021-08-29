
import 'package:bloc_register_login/model/register_user.dart';
import 'package:bloc_register_login/routes/routes.dart';
import 'package:bloc_register_login/screens/login.dart';
import 'package:bloc_register_login/screens/register.dart';
import 'package:bloc_register_login/screens/welcome_page.dart';
import 'package:flutter/material.dart';

// ignore: top_level_function_literal_block
var routes = (RouteSettings settings){
  switch(settings.name){
     //Initial Route
  case Routes.initialRoute:
  return MaterialPageRoute(builder: (context) => LoginScreen());
  case Routes.register:
  return MaterialPageRoute(builder: (context) => SignUp());
  case Routes.welcomePage:
  return MaterialPageRoute(builder: (context) => WelcomePage());
  default:
  }
  return null;
};