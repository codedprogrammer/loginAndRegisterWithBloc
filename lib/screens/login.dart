import 'package:flutter/material.dart';

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
        child: loginForm(),
      ),
    );
  }

  Widget loginForm() {
    return Form(
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
    return TextFormField(
      controller: emailAddress,
      keyboardType: TextInputType.emailAddress,
      validator: (value) => null,
      decoration: InputDecoration(
          hintText: 'Email Address',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
    );
  }

  Widget passwordField() {
    return TextFormField(
      controller: password,
      obscureText: !_passwordVisible,
      validator: (value) => null,
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

  Widget loginButton() {
    return ElevatedButton(
      onPressed: () {},
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

  Widget registerText() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, 
    children: <Widget>[
      Text('Don\'t have an account?',
          style: TextStyle(fontSize: 18, fontStyle: FontStyle.normal)),
      SizedBox(width: 10),
      GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, '/signUpScreen');
        },
              child: Text('Sign Up',
            style: TextStyle(
                color: Colors.purpleAccent,
                fontSize: 18,
                fontStyle: FontStyle.normal)),
      ),
    ]);
  }
}
