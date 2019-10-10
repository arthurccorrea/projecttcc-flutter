import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "https://localhost:8080/horario/api/horarioMarcado";

class API {
  static Future<http.Response> getHorariosMarcados() {
    var url = baseUrl + "/listaHorariosDisponiveis";
    DateTime dateTime = new DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(1565659067675);
    url += "5d437f9c09319a1c44d19e0a/"+ date.toString();
    return http.get(url);

  }
}