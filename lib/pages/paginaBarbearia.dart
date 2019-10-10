import 'package:appbarbearia_flutter/api/BarbeariaApi.dart';
import 'package:appbarbearia_flutter/model/Barbearia.dart';
import 'package:appbarbearia_flutter/model/Estados.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

  Barbearia _barbearia = Barbearia.construct(
    "123",
    "Barbearia do juquinha",
    "A melhor barbearia da região",
    "Salto",
    "Rua coelho Neto Nº338",
    Estados.SP,
    8,
    0,
    16,
    15);



class PaginaBarbearia extends StatefulWidget {

  final id;

  const PaginaBarbearia({Key key, this.id}): super(key: key);

  @override
  _PaginaBarbeariaState createState() => _PaginaBarbeariaState();

}

class _PaginaBarbeariaState extends State<PaginaBarbearia> {

  @override
  Widget build(BuildContext context) {

  Barbearia _barbeariaR;
  var isLoading = false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await BarbeariaApi.getBarbearia(widget.id);
    if (response.statusCode == 200) {
      _barbeariaR = (json.decode(response.body) as Barbearia);
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

    _fetchData();

    return Scaffold(
      appBar: AppBar(
        title: Text(_barbearia.nome),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: ListView(
          children: <Widget>[
            Row(
              children:<Widget> [
               Text("\""+ _barbeariaR.descricao + "\"", style: TextStyle(fontSize: 15, color: Colors.grey),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}