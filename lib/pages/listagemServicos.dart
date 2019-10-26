import 'package:appbarbearia_flutter/model/Servico.dart';
import 'package:flutter/material.dart';

class ListagemServicos extends StatefulWidget {
  final List<Servico> servicos;
  final bool minhaBarbearia;

  const ListagemServicos({this.servicos, this.minhaBarbearia});
  
  @override
  _ListagemServicosState createState() => _ListagemServicosState();
}

class _ListagemServicosState extends State<ListagemServicos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Serviços"),
      ),
      body: ListView.builder(
        itemCount: widget.servicos.length,
        itemBuilder: (context, i) {
          return ListView(
            children: <Widget>[
              FlatButton(
                child: Text(widget.servicos[i].descricao),
                onPressed: () {
                  
                },
              )
            ],
          );
        }
      )
    );
  }
}