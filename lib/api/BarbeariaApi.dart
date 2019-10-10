import 'package:appbarbearia_flutter/HttpResponse/Post.dart';
import 'package:appbarbearia_flutter/model/Barbearia.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const baseUrl = "https://localhost:8080/horario/api/barbearia";

class BarbeariaApi {
  
  static Future<http.Response> saveBarbearia(Barbearia barbearia){
    
    return http.post(baseUrl, body: barbearia, headers: {"Content-type": "application/json"});
    
  }

  static Future<http.Response> getBarbearia(String id){
    return http.get(baseUrl + '/' + id);
  }

  static Future<Barbearia> parseBarbearia(Post post){
      Future<Barbearia> barbearia = json.decode(post.body);
      return barbearia;
  }

  
}