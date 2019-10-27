import 'package:appbarbearia_flutter/model/Barbearia.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaginaBarbearia extends StatefulWidget {

  final Barbearia barbearia;
  final bool sucesso;
  final bool open;
  final String mensagem;

  const PaginaBarbearia({this.barbearia, this.sucesso, this.open, this.mensagem});

  @override
  _PaginaBarbeariaState createState() => _PaginaBarbeariaState();

}

class _PaginaBarbeariaState extends State<PaginaBarbearia> {

  @override
  Widget build(BuildContext context) {

  // Barbearia _barbeariaR;
  // var isLoading = false;

  // _fetchData() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   final response =
  //       await BarbeariaApi.getBarbearia(widget.id);
  //   if (response.statusCode == 200) {
  //     _barbeariaR = (json.decode(response.body) as Barbearia);
  //     setState(() {
  //       isLoading = false;
  //     });
  //   } else {
  //     throw Exception('Failed to load photos');
  //   }
  // }

  //   _fetchData();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.barbearia.nome),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: ListView(
          children: <Widget>[
            Row(
              children:<Widget> [
               Text("\""+ widget.barbearia.descricao + "\"", style: TextStyle(fontSize: 15, color: Colors.grey),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}