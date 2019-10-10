import 'package:appbarbearia_flutter/model/Barbearia.dart';
import 'package:appbarbearia_flutter/model/Estados.dart';
import 'package:appbarbearia_flutter/pages/paginaBarbearia.dart';
import 'package:flutter/material.dart';

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
Barbearia _barbearia2 = Barbearia.construct(
    "123",
    "Barbearia do zézim",
    "COM CERTEZA A MELHOR DA REGIÃO",
    "Salto",
    "Rua Brasil Nº257",
    Estados.SP,
    8,
    0,
    16,
    15);
List<Barbearia> listaBarbearia = [
  _barbearia,
  _barbearia,
  _barbearia,
  _barbearia2
];

class ListagemBarbearia extends StatefulWidget {
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
              itemCount: listaBarbearia.length,
              itemBuilder: (context, i) {
                return new GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new PaginaBarbearia()));
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
                                    listaBarbearia[i].nome,
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            // Column(
                            //   children: <Widget>[
                            //     Padding(
                            //       padding: const EdgeInsets.all(8.0),
                            //       child: ButtonTheme(
                            //         buttonColor: Colors.white,
                            //         minWidth: 10.0,
                            //         child: RaisedButton(
                            //             onPressed: () {
                            //               Navigator.of(context).push(
                            //                   new MaterialPageRoute(
                            //                       builder: (BuildContext
                            //                               context) =>
                            //                           new PaginaBarbearia()));
                            //             },
                            //             child: Icon(
                            //               Icons.exit_to_app,
                            //               size: 30.0,
                            //               color: Colors.grey,
                            //             ),
                            //           ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 6.0, 12.0, 12.0),
                              child: Text(
                                listaBarbearia[i].descricao,
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
                                "Cidade: " + listaBarbearia[i].cidade,
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
