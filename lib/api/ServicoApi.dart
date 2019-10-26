import 'package:appbarbearia_flutter/model/Servico.dart';
import 'package:appbarbearia_flutter/pages/loginPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const baseUrl = "https://tccappbarbearia.herokuapp.com/api/servico";

class ServicoApi {
  static Future<Servico> saveServico(Servico servico) async {
    Map<String, String> headers = new Map<String, String>();
    headers["Content-Type"] = "application/json";
    String token = await authService.obterToken();
    headers["Authorization"] = "Bearer $token";
    String servicoJson = json.encode(servico.toJson());

    Servico responseServico = new Servico();
    Future<http.Response> fResponse =
        http.post(baseUrl, body: servicoJson, headers: headers);
    http.Response response = await fResponse;
    await fResponse.whenComplete(() {
      if (response.statusCode == 200) {
        responseServico = Servico.fromJson(json.decode(response.body));
      }
    });

    return responseServico;
  }
}
