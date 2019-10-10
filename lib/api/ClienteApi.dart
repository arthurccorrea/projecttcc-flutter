import 'package:appbarbearia_flutter/model/Cliente.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://localhost:8080/horario/api/cliente";

class ClienteApi {
  
  static Future<http.Response> saveCliente(Cliente cliente){
    
    return http.post(baseUrl, body: cliente, headers: {"Content-type": "application/json"});
    
  }
}