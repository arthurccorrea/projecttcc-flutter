import 'package:appbarbearia_flutter/HttpResponse/Post.dart';
import 'package:appbarbearia_flutter/model/Barbearia.dart';
import 'package:appbarbearia_flutter/model/User.dart';
import 'package:appbarbearia_flutter/pages/loginPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const baseUrl = "https://tccappbarbearia.herokuapp.com/api/barbearia";

class BarbeariaApi {
  static Future<Barbearia> saveBarbearia(Barbearia barbearia) async {
    Map<String, String> headers = new Map<String, String>();
    headers["Content-Type"] = "application/json";
    String token = await authService.obterToken();
    headers["Authorization"] = "Bearer $token";
    String barbeariaJson = json.encode(barbearia.toJson());

    Barbearia responseBarbearia = new Barbearia();
    Future<http.Response> fResponse = http.post(baseUrl, body: barbeariaJson, headers: headers);
    http.Response response = await fResponse;
    await fResponse.whenComplete(() {
      if (response.statusCode == 200) {
        responseBarbearia = Barbearia.fromJson(json.decode(response.body));
      }
    });

    return responseBarbearia;
  }

  static Future<http.Response> getBarbearia(String id) {
    return http.get(baseUrl + '/' + id);
  }

  static Future<Barbearia> parseBarbearia(Post post) {
    Future<Barbearia> barbearia = json.decode(post.body);
    return barbearia;
  }

  static Future<List<Barbearia>> findCompletoMinhasBarbearias(User user) async{
    Map<String, String> headers = new Map<String, String>();
    headers["Content-Type"] = "application/json";
    String token = await authService.obterToken();
    headers["Authorization"] = "Bearer $token";
    String barbeiroId = user.barbeiro.id;
    Future<http.Response> fResponse = http.get(baseUrl + "/barbeiro/$barbeiroId", headers: headers);
    http.Response response = await fResponse;
    List<Barbearia> barbearias = new List<Barbearia>();

    if(response.statusCode == 200) {
      var responseList = json.decode(response.body) as List;
      barbearias = responseList.map((i) => Barbearia.fromJson(i)).toList();
    }

    return barbearias;
  }

  static Future<Barbearia> findCompleteBarbeariaPorBarbeariaId(String barbeariaId) async {
    Map<String, String> headers = new Map<String, String>();
    headers["Content-Type"] = "application/json";
    String token = await authService.obterToken();
    headers["Authorization"] = "Bearer $token";
    Future<http.Response> fResponse = http.get(baseUrl + "/barbearia/$barbeariaId", headers: headers);
    http.Response response = await fResponse;
    Barbearia barbearia = new Barbearia();
    if(response.statusCode == 200) {
      barbearia = Barbearia.fromJson(json.decode(response.body));
    }

    return barbearia;

  }

  static Future<List<Barbearia>> findAll() async{
    Map<String, String> headers = new Map<String, String>();
    headers["Content-Type"] = "application/json";
    String token = await authService.obterToken();
    headers["Authorization"] = "Bearer $token";
    Future<http.Response> fResponse = http.get(baseUrl, headers: headers);
    http.Response response = await fResponse;
    List<Barbearia> barbearias = new List<Barbearia>();
    await fResponse.whenComplete( () {
      var responseList = json.decode(response.body) as List;
      barbearias = responseList.map((i)=>Barbearia.fromJson(i)).toList();
    });

    return barbearias;
  }

  static Future<List<Barbearia>> findAllByUser(User user
  ) async{
    Map<String, String> headers = new Map<String, String>();
    headers["Content-Type"] = "application/json";
    String token = await authService.obterToken();
    headers["Authorization"] = "Bearer $token";
    String url = baseUrl + "/nearUser/" + user.id;
    Future<http.Response> fResponse = http.get(url, headers: headers);
    http.Response response = await fResponse;
    List<Barbearia> barbearias = new List<Barbearia>();
    await fResponse.whenComplete( () {
      var responseList = json.decode(response.body) as List;
      barbearias = responseList.map((i)=>Barbearia.fromJson(i)).toList();
    });

    return barbearias;
  }


  static Future<List<Barbearia>> findByNome(String nome) async {
    Map<String, String> headers = new Map<String, String>();
    headers["Content-Type"] = "application/json";
    String token = await authService.obterToken();
    headers["Authorization"] = "Bearer $token";
    Future<http.Response> fResponse = http.get(baseUrl + "/nome/$nome" , headers: headers);
    http.Response response = await fResponse;
    List<Barbearia> barbearias = new List<Barbearia>();
    await fResponse.whenComplete( () {
      var responseList = json.decode(response.body) as List;
      barbearias = responseList.map((i)=>Barbearia.fromJson(i)).toList();
    });

    return barbearias;
  } 
}
