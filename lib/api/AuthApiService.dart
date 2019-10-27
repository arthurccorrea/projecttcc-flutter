import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:appbarbearia_flutter/model/User.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class AuthApiService {

  String baseUrl = "https://tccappbarbearia.herokuapp.com/";
  String token;

  // Login
  Future<bool> gerarToken(User user) async {
    File tokenFile = await localFile;
    File loggedUser = await localUserFile;
    if(token == null) {
        Future<http.Response> response = http.post(baseUrl + "autenticacao/obter-token", body: json.encode(user), headers: {"Content-Type": "application/json"});
        http.Response tokenResponse = await response;
        if(tokenResponse.statusCode == 200){
          token = tokenResponse.body;
          tokenFile.writeAsStringSync(token);
          loggedUser.writeAsStringSync(user.username);
          return true;
      }
    }
    return false;
  }

  Future<String> obterToken() async {
    if(token == null || token.isEmpty){
      File tokenFile = await localFile;
      String fileToken = tokenFile.readAsStringSync();
      return fileToken;
    }
    return token;
  }


  // Logout
  void logout() async {
    File tokenFile = await localFile;
    File loggedUser = await localUserFile;
    token = null;
    tokenFile.writeAsStringSync('');
    loggedUser.writeAsStringSync('');
    
  }

  Future<User> getUserByUsername(String username) async{
    String headerToken = await obterToken();
    String tokenForHeader = "Bearer " + headerToken;
    Map<String, String> headers = new Map<String, String>();
    headers['Authorization']=tokenForHeader;
    String requestURL = baseUrl + "user/username/$username";
    Future<http.Response> fResponse = http.get(requestURL, headers: headers);
    http.Response response = await fResponse;
    User user;
    await fResponse.whenComplete( (){
      if(response.statusCode  == 200 || response.statusCode == 400){
        user =  User.fromJson(json.decode(response.body));
      }
    });
    return user;
  }

  Future<String> getLoggedUserUsername() async {
    File loggedUser = await localUserFile;
    return loggedUser.readAsStringSync();
  }

  Future<bool> validarToken(String tokenToValidate) async {
    Map<String, String> headers = new Map<String, String>();
    headers["Content-type"]="application/json";
    headers["Authorization"] = "Bearer $tokenToValidate";
    Future<http.Response> response = http.post(baseUrl + "autenticacao/validar-token", body: "Bearer " + tokenToValidate, headers: headers);
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

  Future<String> get _localUserPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get localUserFile async {
    final path = await _localUserPath;
    File userFile = File('$path/loggedUser.txt');
    bool exists = await userFile.exists();
    if(!exists){
      userFile.create();
    }
    return userFile;
  }
}