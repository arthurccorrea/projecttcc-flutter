import 'dart:async';
import 'package:appbarbearia_flutter/model/HorarioMarcado.dart';
import 'package:appbarbearia_flutter/model/User.dart';
import 'package:appbarbearia_flutter/pages/loginPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const baseUrl = "https://tccappbarbearia.herokuapp.com/api/horarioMarcado/";

class HorarioMarcadoApi {

  static Future<HorarioMarcado> salvarHorarioMarcado(HorarioMarcado horarioMarcado) async {
    Map<String, String> headers = new Map<String, String>();
    headers["Content-Type"] = "application/json";
    String token = await authService.obterToken();
    headers["Authorization"] = "Bearer $token";
    String horarioMarcadoJson = json.encode(horarioMarcado.toJson());

    HorarioMarcado responseHorarioMarcado = new HorarioMarcado();
    Future<http.Response> fResponse = http.post(baseUrl, body: horarioMarcadoJson, headers: headers);
    http.Response response = await fResponse;
    await fResponse.whenComplete(() {
      if (response.statusCode == 200) {
        responseHorarioMarcado = HorarioMarcado.fromJson(json.decode(response.body));
      }
    });

    return responseHorarioMarcado;
  }

 static Future<List<HorarioMarcado>> findHorarioMarcadoByUser(User user) async{
    Map<String, String> headers = new Map<String, String>();
    headers["Content-Type"] = "application/json";
    String token = await authService.obterToken();
    headers["Authorization"] = "Bearer $token";
    String userId = user.id;
    Future<http.Response> fResponse = http.get(baseUrl + "/horariosMarcadosUser/$userId", headers: headers);
    http.Response response = await fResponse;
    List<HorarioMarcado> horariosMarcados = new List<HorarioMarcado>();

    if(response.statusCode == 200) {
      var responseList = json.decode(response.body) as List;
      horariosMarcados = responseList.map((i) => HorarioMarcado.fromJson(i)).toList();
    }

    return horariosMarcados;
  }
}
