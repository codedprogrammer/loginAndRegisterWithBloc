import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc_register_login/config/appconfig.dart';
import 'package:bloc_register_login/core/error_response.dart';
import 'package:bloc_register_login/core/login_successful.dart';
import 'package:bloc_register_login/model/login.dart';
import 'package:bloc_register_login/services/http_requests.dart';
import 'package:http/http.dart';

class AuthRepository {
  Future<dynamic> loginUser({Login login}) async {
    var responseJson;

    try {
      Response response = await HttpService.post('${AppConfig.BASE_URL}${AppConfig.ACCOUNT}${AppConfig.LOGIN}',
              bodyData: loginToJson(login))
          .timeout(Duration(seconds: 100));
          responseJson = _loginResponse(response);
    } on TimeoutException {
      return 'Time Out';
    } on SocketException {
      return 'Socket Error';
    } on HandshakeException {
      return 'Handshake error';
    }
    return responseJson;
  }

  dynamic _loginResponse(Response response) {
  switch (response.statusCode) {
    case 200:
      if (json.decode(response.body)["status"] == 0) {
        return ErrorResponse(error: json.decode(response.body)["message"]);
      }
      return LoginSuccess.fromJson(json.decode(response.body));

    case 307:

    case 400:
      return ErrorResponse(
          error: json.decode(response.body)["errors"].toString());

    case 404:
      return ErrorResponse(error: 'Not found');
    case 401:
      return ErrorResponse(error: 'Session Expired');
    case 403:
      return ErrorResponse(error: 'Current operation failed');
    case 500:
    default:
      return ErrorResponse(error: 'Operation failed. Please try again');
  }
}

}
