
import 'package:appbarbearia_flutter/model/Cliente.dart';
import 'package:appbarbearia_flutter/model/UserClienteWrapper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const baseUrl = "https://tccappbarbearia.herokuapp.com/user/cliente";

class ClienteApi {

  static Future<Cliente> saveCliente(UserClienteWrapper clienteWrapper) async{
//    String token = await authService.obterToken();
//    headers["Authorization"]="Bearer $token";
    String wrapperJson = json.encode(clienteWrapper.toJson());
    Future<http.Response> fResponse = http.post(baseUrl, body: wrapperJson, headers: {"Content-Type": "application/json"});
    http.Response response = await fResponse;

    if(response.statusCode == 200){
      return Cliente.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      return clienteWrapper.cliente;
    } else if (response.statusCode == 400) {
      String body = response.body;
      print(body);
      return clienteWrapper.cliente;
    }

    return null;
  }
}