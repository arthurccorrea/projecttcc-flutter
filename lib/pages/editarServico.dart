import 'package:appbarbearia_flutter/api/BarbeariaApi.dart';
import 'package:appbarbearia_flutter/api/ServicoApi.dart';
import 'package:appbarbearia_flutter/model/Barbearia.dart';
import 'package:appbarbearia_flutter/model/Servico.dart';
import 'package:appbarbearia_flutter/model/User.dart';
import 'package:appbarbearia_flutter/pages/minhaBarbearia.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditarServico extends StatefulWidget {
  final Barbearia barbearia;
  final Servico servico;
  final User loggedUser;

  const EditarServico({this.barbearia, this.loggedUser, this.servico});

  @override
  _EditarServicoState createState() => _EditarServicoState();
}

class _EditarServicoState extends State<EditarServico> {
  Servico _servico;
  final _formKey = GlobalKey<FormState>();
  var _eDescricao;
  var _eCusto;
  // var _eCusto = MoneyMaskedTextController(decimalSeparator: ".", leftSymbol: "R0\$");
  @override
  void initState() {
    _servico = widget.servico;
    _eDescricao = TextEditingController(text: widget.servico.descricao);
    _eCusto = TextEditingController(text: widget.servico.preco.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text("Editar " + widget.servico.descricao),
        ),
        body: Container(
            child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                autocorrect: false,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Este campo é obrigatório';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.mail),
                  hasFloatingPlaceholder: true,
                  hintText: "Descrição (*)",
                ),
                controller: _eDescricao,
                onChanged: (descricao) {
                  _servico.descricao = descricao;
                },
              ),
              TextFormField(
                autocorrect: false,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Este campo é obrigatório';
                  }
                  return null;
                },
                inputFormatters: <TextInputFormatter>[
                  BlacklistingTextInputFormatter(new RegExp('[\\-|\\ ]'))
                ],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  icon: Icon(Icons.mail),
                  hasFloatingPlaceholder: true,
                  hintText: "Valor (*)",
                ),
                controller: _eCusto,
                onChanged: (custo) {
                  custo.replaceAll(".", ",");
                  _servico.preco = double.parse(custo);
                },
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      child: RaisedButton(
                        child: Text("Editar"),
                        key: Key("_submitButton"),
                        onPressed: () async {
                          Barbearia responseBarbearia =
                              await _saveServico(_servico, widget.barbearia);
                          if (responseBarbearia != null &&
                              responseBarbearia.id != null) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new MinhaBarbearia(
                                          barbearia: responseBarbearia,
                                          loggedUser: widget.loggedUser,
                                          sucesso: true,
                                          open: false,
                                          mensagem:
                                              "Serviço alterado com sucesso!",
                                        )));
                          } else {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new MinhaBarbearia(
                                            barbearia: widget.barbearia,
                                            loggedUser: widget.loggedUser,
                                            sucesso: false,
                                            open: false,
                                            mensagem:
                                                "Algo deu errado na alteração de serviço!")));
                          }
                        },
                        elevation: 3.0,
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ButtonTheme(
                      buttonColor: Colors.red,
                      minWidth: double.infinity,
                      child: RaisedButton(
                        child: Text("Excluir!"),
                        key: Key("_submitButton"),
                        onPressed: () async {
                          bool deleteResponse = await _deleteServico(widget.servico);
                          if (deleteResponse) {
                          Barbearia responseBarbearia = await BarbeariaApi.findCompleteBarbeariaPorBarbeariaId(widget.barbearia.id);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new MinhaBarbearia(
                                          barbearia: responseBarbearia,
                                          loggedUser: widget.loggedUser,
                                          sucesso: true,
                                          open: false,
                                          mensagem:
                                              "Serviço excluido com sucesso!",
                                        )));
                          } else {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new MinhaBarbearia(
                                            barbearia: widget.barbearia,
                                            loggedUser: widget.loggedUser,
                                            sucesso: false,
                                            open: false,
                                            mensagem:
                                                "Algo deu errado hora de excluir o serviço!")));
                          }
                        },
                        elevation: 3.0,
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )));
  }
}

Future<Barbearia> _saveServico(Servico servico, Barbearia barbearia) async {
  Future<Servico> fServico = ServicoApi.saveServico(servico);
  Servico responseServico = await fServico;
  if (responseServico.id == null) {
    return new Barbearia();
  }
  Future<Barbearia> fBarbearia =
      BarbeariaApi.findCompleteBarbeariaPorBarbeariaId(barbearia.id);
  Barbearia responseBarbearia = await fBarbearia;

  return responseBarbearia;
}

Future<bool> _deleteServico(Servico servico) async {
  bool sucesso = await ServicoApi.removeServico(servico);

  return sucesso;
}
