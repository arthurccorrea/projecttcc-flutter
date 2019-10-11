import 'dart:async';
import 'dart:io';

import 'package:appbarbearia_flutter/model/User.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

class AuthApiService {

  String _BASE_URL = "https://tccappbarbearia.herokuapp.com/";
  String token;

  // Login
  Future<bool> obterToken(User user) async {
    File tokenFile = await localFile;
      if(token == null) {
      Future<http.Response> response = http.post(_BASE_URL + "autenticacao/obter-token", body: json.encode(user), headers: {"Content-Type": "application/json"});
      http.Response tokenResponse = await response;
      if(tokenResponse.statusCode == 200){
        token = tokenResponse.body;
        tokenFile.writeAsStringSync(token);
        return true;
      }
    }

    return false;
  }

  // Logout
  void logout() async {
    File tokenFile = await localFile;
    token = null;
    tokenFile.writeAsStringSync('');
  }

  Future<bool> validarToken(String tokenToValidate) async {
    Map<String, String> headers = new Map<String, String>();
    headers["Content-type"]="application/json";
    headers["Authorization"] = "Bearer $tokenToValidate";
    Future<http.Response> response = http.post(_BASE_URL + "autenticacao/validar-token", body: "Bearer " + tokenToValidate, headers: headers);
    http.Response tokenResponse = await response;
    if(tokenResponse.statusCode != 200){
      return false;
    }

    return true;
  }

    Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

    Future<File> get localFile async {
    final path = await _localPath;
    File tokenFile = File('$path/token.txt');
    bool exists = await tokenFile.exists();
    if(!exists){
      tokenFile.create();
    }
    return tokenFile;
  }
}