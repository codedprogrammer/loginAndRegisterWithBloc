import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  String firstName;
  String lastName;
  String emailAddress;
  String password;

  Register({this.firstName, this.lastName, this.emailAddress, this.password});

  factory Register.fromJson(Map<String, dynamic> json) => Register(
      firstName: json["firstName"],
      lastName: json["lastName"],
      emailAddress: json["emailAddress"],
      password: json["password"]);

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "emailAddress": emailAddress,
        "password": password
      };
}
