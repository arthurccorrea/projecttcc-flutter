import 'package:appbarbearia_flutter/HttpResponse/Post.dart';
import 'package:appbarbearia_flutter/model/Barbearia.dart';
import 'package:appbarbearia_flutter/pages/loginPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const baseUrl = "https://localhost:8080/horario/api/barbearia";

class BarbeariaApi {
  
  static Future<http.Response> saveBarbearia(Barbearia barbearia) async{
    Map<String, String> headers = new Map<String, String>();
    headers["Content-Type"]="application/json";
    String token = await authService.obterToken();
    headers["Authorization"]="Bearer $token"; 
    String barbeariaJson = json.encode(barbearia.toJson());
    
    return http.post(baseUrl, body: barbeariaJson, headers: {"Content-type": "application/json"});
    
  }

  static Future<http.Response> getBarbearia(String id){
    return http.get(baseUrl + '/' + id);
  }

  static Future<Barbearia> parseBarbearia(Post post){
      Future<Barbearia> barbearia = json.decode(post.body);
      return barbearia;
  }

  
}