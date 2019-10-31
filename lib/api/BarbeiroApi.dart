
import 'package:appbarbearia_flutter/model/Barbeiro.dart';
import 'package:appbarbearia_flutter/model/UserBarbeiroWrapper.dart';
import 'package:appbarbearia_flutter/pages/loginPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const baseUrl = "https://tccappbarbearia.herokuapp.com/user/barbeiro";
const baseUrlBarbeariaApi = "https://tccappbarbearia.herokuapp.com/users/barbearia";

class BarbeiroApi {

  static Future<Barbeiro> saveBarbeiro(UserBarbeiroWrapper barbeiroWrapper) async{
//    String token = await authService.obterToken();
//    headers["Authorization"]="Bearer $token";
    String wrapperJson = json.encode(barbeiroWrapper.toJson());
    Future<http.Response> fResponse = http.post(baseUrl, body: wrapperJson, headers: {"Content-Type": "application/json"});
    http.Response response = await fResponse;

    if(response.statusCode == 200){
      return Barbeiro.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      return barbeiroWrapper.barbeiro;
    } else if (response.statusCode == 400) {
      String body = response.body;
      print(body);
      return barbeiroWrapper.barbeiro;
    }

    return null;
  }

  static Future<Barbeiro> saveBarbeiroParaBarbearia(UserBarbeiroWrapper barbeiroWrapper) async {
     Map<String, String> headers = new Map<String, String>();
    headers["Content-Type"] = "application/json";
    String token = await authService.obterToken();
    headers["Authorization"] = "Bearer $token";
    String barbeiroWrapperJson = json.encode(barbeiroWrapper.toJson());

    Future<http.Response> fResponse = http.post(baseUrlBarbeariaApi, body: barbeiroWrapperJson, headers: headers);
    http.Response response = await fResponse;

    if(response.statusCode == 200){
      return Barbeiro.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      return barbeiroWrapper.barbeiro;
    } else if (response.statusCode == 400) {
      String body = response.body;
      print(body);
      return barbeiroWrapper.barbeiro;
    }

    return null;
  }
}