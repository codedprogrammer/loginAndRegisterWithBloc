import 'dart:convert';

import 'package:bloc_register_login/auth/auth_repository.dart';
import 'package:bloc_register_login/auth/form_submission_status.dart';
import 'package:bloc_register_login/auth/login/login_bloc.dart';
import 'package:bloc_register_login/auth/login/login_event.dart';
import 'package:bloc_register_login/auth/login/login_state.dart';
import 'package:bloc_register_login/screens/register.dart';
import 'package:bloc_register_login/screens/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) =>
              LoginBloc(authRepository: context.read<AuthRepository>()),
          child: loginForm(),
        ),
      ),
    );
  }

  Widget loginForm() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state){
        final formStatus = state.formStatus;
        if(formStatus == SubmissionFailed){
        showSnackBar(context, formStatus.toString());
        }
      },
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              illustrationImage(),
              SizedBox(height: 20),
              loginText(),
              SizedBox(height: 20),
              emailAddressField(),
              SizedBox(height: 30),
              passwordField(),
              SizedBox(height: 30),
              loginButton(),
              SizedBox(height: 30),
              registerText()
            ],
          ),
        ),
      ),
    );
  }

  Widget illustrationImage() {
    return Container(
      alignment: Alignment.center,
      child: Image.asset(
        'assets/images/login_illustration.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget loginText() {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Column(children: <Widget>[
        Text('Let\'s Sign You In',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal)),
        SizedBox(height: 10),
        Text('Welcome back, You\'ve been missed!',
            style: TextStyle(fontSize: 18, fontStyle: FontStyle.normal)),
      ]),
    );
  }

  Widget emailAddressField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        controller: emailAddress,
        keyboardType: TextInputType.emailAddress,
        validator: (value) => null,
        onChanged: (value) => context.read<LoginBloc>().add(
              LoginUsernameChanged(username: value),
            ),
        decoration: InputDecoration(
            hintText: 'Email Address',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      );
    });
  }

  Widget passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        controller: password,
        obscureText: !_passwordVisible,
        validator: (value) => null,
        onChanged: (value) => context.read<LoginBloc>().add(
              LoginPasswordChanged(password: value),
            ),
        decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
            hintText: 'Password',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      );
    });
  }

  Widget loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? Center(child: CircularProgressIndicator())
          : ElevatedButton(
              onPressed: () {
                login();
                // signInUser();
                // context.read<LoginBloc>().add(LoginSubmittedButton());
              },
              style: ButtonStyle(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Log In',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.normal),
                ),
              ),
            );
    });
  }

  Widget registerText() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text('Don\'t have an account?',
          style: TextStyle(fontSize: 18, fontStyle: FontStyle.normal)),
      SizedBox(width: 10),
      GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUp()));
        },
        child: Text('Sign Up',
            style: TextStyle(
                color: Colors.purpleAccent,
                fontSize: 18,
                fontStyle: FontStyle.normal)),
      ),
    ]);
  }

  void showSnackBar(BuildContext context, String message){
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

//   signInUser() async {
//     accountBloc.add(LoginUser(login: loginForm));

// }



Future<dynamic> login() async {
  final response = await http.post(
      Uri.parse('https://rapidapi.com/arupsarkar/api/login-signup/'),
      headers: <String, String>{
            'Origin': 'http://127.0.0.1',
            'X-RapidAPI-Key': 'e068e353demsh7404948073ace75p140f87jsn4e46e0e88eed'.toString(),
            'X-RapidAPI-Host': 'login-signup.p.rapidapi.com'
          },
      body:  jsonEncode(<String, String>{
            'email': emailAddress.text,
            'password': password.text
          }));

  if (response.statusCode == 200 && emailAddress.text.isNotEmpty && password.text.isNotEmpty) {
    // If the server did return a 200 OK response, then parse the JSON.
    return Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomePage()));
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    createSnackBar('Invalid username / or password');
    throw Exception('User or Password was incorrect.');
  }
}

void createSnackBar(String message) {                                                                               
  final snackBar = new SnackBar(content: new Text(message),                                                         
  backgroundColor: Colors.red);                                                                                      

  // Find the Scaffold in the Widget tree and use it to show a SnackBar!                                            
  ScaffoldMessenger.of(context).showSnackBar(
          snackBar
        );                                                              
  } 

}