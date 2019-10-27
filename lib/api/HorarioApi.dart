import 'dart:async';
import 'package:appbarbearia_flutter/model/Barbeiro.dart';
import 'package:appbarbearia_flutter/model/Horario.dart';
import 'package:appbarbearia_flutter/pages/loginPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const baseUrl = "https://tccappbarbearia.herokuapp.com/api/horarioMarcado/";

class HorarioApi {

  static Future<List<Horario>> getHorariosDisponiveisBarbearia(
    DateTime data, Barbeiro barbeiro) async {
    Map<String, String> headers = new Map<String, String>();
    headers["Content-Type"] = "application/json";
    String token = await authService.obterToken();
    headers["Authorization"] = "Bearer $token";
    var url = baseUrl + "horariosDisponiveis/" + barbeiro.id + "/" + data.millisecondsSinceEpoch.toString();
    Future<http.Response> fResponse = http.get(url, headers: headers);
    http.Response response = await fResponse;
    List<Horario> horarios = new List<Horario>();

    if(response.statusCode == 200) {
      var responseList = json.decode(response.body) as List;
      horarios = responseList.map((i) => Horario.fromJson(i)).toList();
    }

    return horarios;
  }
}
