import 'package:appbarbearia_flutter/api/BarbeariaApi.dart';
import 'package:appbarbearia_flutter/model/Barbearia.dart';
import 'package:appbarbearia_flutter/model/User.dart';
import 'package:appbarbearia_flutter/pages/paginaBarbearia.dart';
import 'package:flutter/material.dart';

class PesquisaBarbearias extends StatefulWidget {
  final User loggedUser;
  final List<Barbearia> barbearias;

  const PesquisaBarbearias({this.loggedUser, this.barbearias});

  @override
  _PesquisaBarbeariasState createState() => _PesquisaBarbeariasState();
}

class _PesquisaBarbeariasState extends State<PesquisaBarbearias> {
  final _formKey = GlobalKey<FormState>();
  String _busca = "";
  List<Barbearia> barbearias;
  var _eBusca = new TextEditingController();

  @override
  void initState() {
    barbearias = widget.barbearias;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Busca por nome"),
      ),
    body: Container(
      margin: EdgeInsets.all(7.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                TextFormField(
                decoration: const InputDecoration(
                    icon: Icon(Icons.search),
                    hasFloatingPlaceholder: true,
                    hintText: "Insira o nome da barbearia para busca"),
                controller: _eBusca,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Você não pode procurar uma barbearia sem escrever o nome dela';
                  }
                  return null;
                },
                onChanged: (busca) {
                  _busca = busca;
                },
              ),
              ButtonTheme(
                minWidth: double.infinity,
                child: RaisedButton.icon(
                  icon: Icon(Icons.search),
                  label: Text("Pesquisar"),
                  textColor: Colors.white,
                  onPressed: () async {
                    if (_formKey.currentState.validate()){
                      List<Barbearia> _barbeariaResponse = await BarbeariaApi.findByNome(_busca);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => new PesquisaBarbearias(loggedUser: widget.loggedUser, barbearias: _barbeariaResponse,)));
                    }
                  },
                ),
              ),
              for (Barbearia barbearia in barbearias) GestureDetector(
                  onTap: () async {
                    Barbearia responseBarbearia =
                        await BarbeariaApi.findCompleteBarbeariaPorBarbeariaId(
                            barbearia.id);
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new PaginaBarbearia(
                            barbearia: responseBarbearia,
                            open: true,
                            sucesso: true,
                            loggedUser: widget.loggedUser,
                            mensagem: "")));
                  },
                  child: new Card(
                    margin: EdgeInsets.fromLTRB(0, 2, 0, 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                      Column(
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
                                    barbearia.nome,
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
                                barbearia.descricao,
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
                                "Cidade: " + barbearia.cidade,
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
                    ],
                    )
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
    );
  }
}