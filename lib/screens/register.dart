import 'dart:convert';

import 'package:bloc_register_login/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _passwordVisible = false;
  final formKey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: registerForm(),
      ),
    );
  }

  Widget registerForm() {
    return Form(
      key: formKey1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            illustrationImage(),
            registerText(),
            SizedBox(height: 20),
            firstNameField(),
            SizedBox(height: 30),
            lastNameField(),
            SizedBox(height: 30),
            emailAddressField(),
            SizedBox(height: 30),
            passwordField(),
            SizedBox(height: 30),
            signUpButton(),
            SizedBox(height: 30),
            loginText()
          ],
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

  Widget registerText() {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Column(children: <Widget>[
        Text('Create An Account',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal)),
        SizedBox(height: 10),
        Text('Join us, We\'re happy to have you',
            style: TextStyle(fontSize: 18, fontStyle: FontStyle.normal)),
      ]),
    );
  }

  Widget firstNameField() {
    return TextFormField(
      controller: firstName,
      decoration: InputDecoration(
          hintText: 'First Name',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
    );
  }

  Widget lastNameField() {
    return TextFormField(
      controller: lastName,
      decoration: InputDecoration(
          hintText: 'Last Name',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
    );
  }

  Widget emailAddressField() {
    return TextFormField(
      controller: emailAddress,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'Email Address',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
    );
  }

  Widget passwordField() {
    return TextFormField(
      controller: password,
      obscureText: !_passwordVisible,
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
    );
  }

  Widget signUpButton() {
    return ElevatedButton(
      onPressed: () {
        register();
      },
      style: ButtonStyle(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Sign Up',
          style: TextStyle(fontSize: 18, fontStyle: FontStyle.normal),
        ),
      ),
    );
  }

  Widget loginText() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text('Have an account?',
          style: TextStyle(fontSize: 18, fontStyle: FontStyle.normal)),
      SizedBox(width: 10),
      GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Text('Log In',
            style: TextStyle(
                color: Colors.purpleAccent,
                fontSize: 18,
                fontStyle: FontStyle.normal)),
      ),
    ]);
  }

  Future<dynamic> register() async {
    final response = await http.post(
        Uri.parse('https://rapidapi.com/arupsarkar/api/login-signup/'),
        headers: <String, String>{
          'Origin': 'http://127.0.0.1',
          'X-RapidAPI-Key':
              'e068e353demsh7404948073ace75p140f87jsn4e46e0e88eed'.toString(),
          'X-RapidAPI-Host': 'login-signup.p.rapidapi.com'
        },
        body: jsonEncode(<String, String>{
          'f_name': firstName.text,
          'l_name': lastName.text,
          'email': emailAddress.text,
          'password': password.text
        }));

    if (response.statusCode == 200 &&
        firstName.text.isNotEmpty &&
        lastName.text.isNotEmpty &&
        emailAddress.text.isNotEmpty &&
        password.text.isNotEmpty) {
      // If the server did return a 200 OK response, then parse the JSON.
      Navigator.pop(context);
      createSnackBar('Registration Successful');
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      createSnackBar('Registration failed');
      throw Exception('User or Password was incorrect.');
    }
  }

  void createSnackBar(String message) {
    final snackBar =
        new SnackBar(content: new Text(message), backgroundColor: Colors.green);

    // Find the Scaffold in the Widget tree and use it to show a SnackBar!
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
