import 'package:appbarbearia_flutter/api/BarbeariaApi.dart';
import 'package:appbarbearia_flutter/model/Barbearia.dart';
import 'package:appbarbearia_flutter/model/User.dart';
import 'package:appbarbearia_flutter/pages/minhaBarbearia.dart';
import 'package:appbarbearia_flutter/pages/paginaBarbearia.dart';
import 'package:flutter/material.dart';

class ListagemBarbearia extends StatefulWidget {
  final User loggedUser;
  final List<Barbearia> barbearias;
  final bool minhasBarbearias;

  const ListagemBarbearia({this.loggedUser, this.barbearias, this.minhasBarbearias});

  @override
  State<StatefulWidget> createState() {
    return new _ListagemBarebeariaState();
  }
}

class _ListagemBarebeariaState extends State<ListagemBarbearia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Barbearias"),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 5.0),
          child: ListView.builder(
              itemCount: widget.barbearias.length,
              itemBuilder: (context, i) {
                return new GestureDetector(
                  onTap: () async {
                    Barbearia barbearia =
                        await BarbeariaApi.findCompleteBarbeariaPorBarbeariaId(
                            widget.barbearias[i].id);
                    !widget.minhasBarbearias ? Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new PaginaBarbearia(
                            barbearia: barbearia,
                            open: true,
                            sucesso: true,
                            loggedUser: widget.loggedUser,
                            mensagem: ""))) : Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new MinhaBarbearia(
                            barbearia: barbearia,
                            barbeiro: widget.loggedUser.barbeiro,
                            open: true,
                            sucesso: true,
                            loggedUser: widget.loggedUser,
                            mensagem: ""))); 
                  },
                  child: new Card(
                    margin: EdgeInsets.fromLTRB(0, 2, 0, 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Wrap(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      12.0, 12.0, 12.0, 6.0),
                                  child: Text(
                                    widget.barbearias[i].nome,
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 6.0, 12.0, 12.0),
                              child: Text(
                                widget.barbearias[i].descricao,
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 6.0, 12.0, 12.0),
                              child: Text(
                                "Cidade: " + widget.barbearias[i].cidade,
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                            // Divider(
                            //   height: 2.0,
                            //   color: Colors.grey,
                            // )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}
