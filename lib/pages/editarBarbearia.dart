import 'package:appbarbearia_flutter/api/BarbeariaApi.dart';
import 'package:appbarbearia_flutter/model/Barbearia.dart';
import 'package:appbarbearia_flutter/model/Barbeiro.dart';
import 'package:appbarbearia_flutter/model/Estados.dart';
import 'package:appbarbearia_flutter/model/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  var _eFoto;
  var _eNome;
  var _eDescricao;
  var _eCidade;
  var _eEndereco;
  var _eEstado;
  var _eHoraAbertura;
  var _eMinutoAbertura;
  var _eHoraFechamento;
  var _eMinutoFechamento;
  List<int> _eHoras = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24];
  List<int> _eMinutos = [0,15,30,45];
  DateFormat formatHora = new DateFormat("hh:mm");
  DateFormat formatDia = new DateFormat("dd/MM/yyyy");

  @override
  void initState() {
    _barbearia = widget.barbearia;
    DateFormat getHora = new DateFormat("HH");
    DateFormat getMinutos = new DateFormat("mm");
    _eFoto = TextEditingController(text: widget.barbearia.foto);
    _eNome = TextEditingController(text: widget.barbearia.nome);
    _eDescricao = TextEditingController(text: widget.barbearia.descricao);
    _eCidade = TextEditingController(text: widget.barbearia.cidade);
    _eEstado = widget.barbearia.estado;
    _eEndereco = TextEditingController(text: widget.barbearia.endereco);
    _eHoraAbertura = int.parse(getHora.format(widget.barbearia.horarioAbertura));
    _eMinutoAbertura = int.parse(getMinutos.format(widget.barbearia.horarioAbertura));
    _eHoraFechamento = int.parse(getHora.format(widget.barbearia.horarioFechamento));
    _eMinutoFechamento = int.parse(getMinutos.format(widget.barbearia.horarioFechamento));
    _barbearia.horaAbertura =  _eHoraAbertura;
    _barbearia.minutoAbertura = _eMinutoAbertura;
    _barbearia.horaFechamento =_eHoraFechamento;
    _barbearia.minutoFechamento = _eMinutoFechamento;
    
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
                  decoration: const InputDecoration(
                    icon: Icon(FontAwesomeIcons.image),
                    hasFloatingPlaceholder: true,
                    hintText: "Coloque uma imagem da sua barbearia"
                  ),
                  controller: _eFoto,
                  onChanged: (foto) {
                    _barbearia.foto = foto;
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
                    icon: Icon(FontAwesomeIcons.home),
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
                        value: _eHoraAbertura,
                        onChanged: (int newValue){
                          setState(() {
                           _eHoraAbertura = newValue;
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
                        value: _eMinutoAbertura,
                        onChanged: (int newValue){
                          setState((){
                            _eMinutoAbertura = newValue;
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
                        value: _eHoraFechamento,
                        onChanged: (int newValue){
                          setState((){
                            _eHoraFechamento = newValue;
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
                        value: _eMinutoFechamento,
                        onChanged: (int newValue){
                          setState((){
                            _eMinutoFechamento = newValue;
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
                              await _saveBarbearia(_barbearia, widget.loggedUser);
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
                                          barbeiro: widget.loggedUser.barbeiro,
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

Future<Barbearia> _saveBarbearia(Barbearia barbearia, User user) async{
  List<Barbeiro> barbeiros = new List<Barbeiro>();
  barbeiros.add((user.barbeiro));
  barbearia.barbeiros = barbeiros;
  Future<Barbearia> fBarbearia = BarbeariaApi.saveBarbearia(barbearia);
  Barbearia responseBarbearia = await fBarbearia;
  return responseBarbearia;

}

}