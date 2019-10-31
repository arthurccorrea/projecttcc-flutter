import 'package:appbarbearia_flutter/api/BarbeariaApi.dart';
import 'package:appbarbearia_flutter/model/Barbearia.dart';
import 'package:appbarbearia_flutter/model/Estados.dart';
import 'package:appbarbearia_flutter/model/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'minhaBarbearia.dart';

class EditarBarbearia extends StatefulWidget {
  final Barbearia barbearia;
  final User loggedUser;

  const EditarBarbearia({this.barbearia, this.loggedUser});

   @override
  _EditarBarbeariaState createState() => _EditarBarbeariaState();

}

class _EditarBarbeariaState extends State<EditarBarbearia>{
  Barbearia _barbearia;
  final _formKey = GlobalKey<FormState>();
  var _eNome;
  var _eDescricao;
  var _eCidade;
  var _eEndereco;
  var _eEstado;
  var _ehoraAbertura;
  var _eminutoAbertura;
  var _ehoraFechamento;
  var _eminutoFechamento;
  List<int> _eHoras = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24];
  List<int> _eMinutos = [0,15,30,45];
  DateFormat formatHora = new DateFormat("hh:mm");
  DateFormat formatDia = new DateFormat("dd/MM/yyyy");

  @override
  void initState() {
    _eNome = TextEditingController(text: widget.barbearia.nome);
    _eDescricao = TextEditingController(text: widget.barbearia.descricao);
    _eCidade = TextEditingController(text: widget.barbearia.cidade);
    _eEstado = Estados.AC;
    _eEndereco = TextEditingController(text: widget.barbearia.descricao);
    _ehoraAbertura = 1;
    _eminutoAbertura = 0;
    _ehoraFechamento = 1;
    _eminutoFechamento = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Editar barbearia"),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget> [
            TextFormField(
              autocorrect: false,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Este campo é obrigatório';
                }
                return null;
              },
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hasFloatingPlaceholder: true,
                hintText: "Insira o nome"
              ),
              controller: _eNome,
              onChanged: (nome) {
                _barbearia.nome = nome;
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
                decoration: const InputDecoration(
                  icon: Icon(Icons.content_paste),
                    hasFloatingPlaceholder: true,
                    hintText: "Descreva a sua barbearia"
                ),
                controller: _eDescricao,
                onChanged: (descricao) {
                  _barbearia.descricao = descricao;
                },
            ),
            Divider(),
            Align(
              alignment: Alignment.center,
              child: Text("ENDERECO"),
            ),
            TextFormField(
               decoration: const InputDecoration(
                    icon: Icon(Icons.map),
                    hasFloatingPlaceholder: true,
                    hintText: "Cidade"
                  ),
                  controller: _eCidade,
                  onChanged: (cidade) {
                    _barbearia.cidade = cidade;
                  },
                  validator: (value) {
                    if(value.isEmpty){
                      return 'Este campo é obrigatório';
                    }
                    return null;
                  },
            ),
            TextFormField(
              decoration: const InputDecoration(
                    icon: Icon(Icons.location_city),
                    hasFloatingPlaceholder: true,
                    hintText: "Logradouro"
                  ),
                  controller: _eEndereco,
                  validator: (value) {
                    if(value.isEmpty){
                      return 'Este campo é obrigatório';
                    }
                    return null;
                  },
                  onChanged: (endereco) {
                    _barbearia.endereco = endereco;
                  }
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: <Widget>[
                 Text("Selecione a sigla do seu estado",
                 style: TextStyle(fontWeight: FontWeight.bold)),
                 new DropdownButton<Estados>(
                   iconEnabledColor: Colors.red,
                      value: _eEstado,
                      onChanged: (Estados newValue) {
                        setState(() {
                          _barbearia.estado = newValue;
                          _eEstado = newValue;
                        });
                      },
                      items: Estados.values.map((Estados _estado) {
                        return new DropdownMenuItem<Estados>(
                          value: _estado,
                          child: new Text(_estado.toString().replaceAll("Estados.", "")));
                      }).toList()
                      )
                  ],
                ),
                Divider(),
                Align(
                  alignment: Alignment.center,
                  child: Text("HORARIOS"),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text("Horario de abertura"),
                    ),
                    Expanded(
                      child: new DropdownButton<int>(
                        value: _ehoraAbertura,
                        onChanged: (int newValue){
                          setState(() {
                           _ehoraAbertura = newValue;
                           _barbearia.horaAbertura = newValue; 
                          });
                        },
                        items: _eHoras.map((int _valueAbertura) {
                        return new DropdownMenuItem<int>(
                          value: _valueAbertura,
                          child: new Text(_valueAbertura.toString()));
                        }).toList()                                            
                      )
                    ),
                    Expanded(child: new DropdownButton<int>(
                        value: _eminutoAbertura,
                        onChanged: (int newValue){
                          setState((){
                            _eminutoAbertura = newValue;
                            _barbearia.minutoAbertura = newValue;
                          });
                        },
                        items: _eMinutos.map((int _valueFechamento) {
                        return new DropdownMenuItem<int>(
                          value: _valueFechamento,
                          child: new Text(_valueFechamento.toString()));
                        }).toList()
                        ))
                    ]
                  ),
                  Row(
                  children: <Widget>[
                    Expanded(
                      child: Text("Horario de Fechamento")
                    ),
                    Expanded(
                      child: new DropdownButton<int>(
                        value: _ehoraFechamento,
                        onChanged: (int newValue){
                          setState((){
                            _ehoraFechamento = newValue;
                            _barbearia.horaFechamento = newValue;
                          });
                        },
                        items: _eHoras.map((int _value) {
                        return new DropdownMenuItem<int>(
                          value: _value,
                          child: new Text(_value.toString()));
                        }).toList()
                        )
                      ),
                      Expanded(child: new DropdownButton<int>(
                        value: _eminutoFechamento,
                        onChanged: (int newValue){
                          setState((){
                            _eminutoFechamento = newValue;
                            _barbearia.minutoFechamento = newValue;
                          });
                        },
                        items: _eMinutos.map((int _value) {
                        return new DropdownMenuItem<int>(
                          value: _value,
                          child: new Text(_value.toString()));
                        }).toList()
                        ))
                    ]
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
                              await _saveBarbearia(_barbearia);
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
                                              "Barbaria alterado com sucesso!",
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
                                                "Algo deu errado na alteração da Barbearia!")));
                          }
                        },
                        elevation: 3.0,
                        color: Colors.purple,
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ] 
          )
        ),
      ),
    );
    
    }

    Future<Barbearia> _saveBarbearia(Barbearia barbearia) async {
  Future<Barbearia> fBarbearia = BarbeariaApi.saveBarbearia(barbearia);
  Barbearia responseServico = await fBarbearia;
  if (responseServico.id == null) {
    return new Barbearia();
  }  
  Barbearia responseBarbearia = await fBarbearia;

  return responseBarbearia;
}

}