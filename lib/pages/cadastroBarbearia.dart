import 'package:appbarbearia_flutter/api/BarbeariaApi.dart';
import 'package:appbarbearia_flutter/model/Barbearia.dart';
import 'package:appbarbearia_flutter/model/Barbeiro.dart';
import 'package:appbarbearia_flutter/model/Estados.dart';
import 'package:appbarbearia_flutter/model/Servico.dart';
import 'package:appbarbearia_flutter/model/User.dart';
import 'package:appbarbearia_flutter/pages/paginaBarbearia.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CadastroBarbearia extends StatefulWidget {
  final bool sucesso;
  final bool open;
  final String mensagem;
  final User loggedUser;

  const CadastroBarbearia({this.sucesso, this.open, this.mensagem,this.loggedUser});

  @override
  _CadastroBarbeariaState createState() => _CadastroBarbeariaState();
}

class _CadastroBarbeariaState extends State<CadastroBarbearia> {
  Barbearia barbearia = new Barbearia();
  var _foto = TextEditingController();
  var _nome = TextEditingController();
  var _descricao = TextEditingController();
  var _cidade = TextEditingController();
  var _logradouro = TextEditingController();
  Estados _estado = Estados.AC;
  List<int> _horas = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24];
  int _horaAbertura = 1;
  int _minutoAbertura = 0;
  int _horaFechamento = 1;
  int _minutoFechamento = 0;
  List<int> _minutos = [0,15,30,45];
  final _cadastroBarbeariaKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text("Cadastre sua barbearia")),
      body: Container(
        child: Form(
        key: _cadastroBarbeariaKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            !widget.open && !widget.sucesso ? _loadMensagemDeErro(widget.mensagem) : Text(""),
            TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hasFloatingPlaceholder: true,
                    hintText: "Insira o nome"
                  ),
                  validator: (value) {
                    if(value.isEmpty){
                      return 'Este campo é obrigatório';
                    }
                    if(value.length > 32) {
                      return 'O nome não pode ser maior que 32 caracteres';
                    }
                    return null;
                  },
                  controller: _nome,
                  onChanged: (nome){
                    barbearia.nome = nome;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(FontAwesomeIcons.image),
                    hasFloatingPlaceholder: true,
                    hintText: "Coloque uma imagem da sua barbearia"
                  ),
                  controller:  _foto,
                  onChanged: (foto) {
                    barbearia.foto = foto;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.content_paste),
                    hasFloatingPlaceholder: true,
                    hintText: "Descreva a sua barbearia"
                  ),
                  controller: _descricao,
                  validator: (value) {
                    if(value.isEmpty){
                      return 'Este campo é obrigatório';
                    }
                    if(value.length > 100) {
                      return 'A descrição deve ter no máximo 100 caracteres';
                    }
                    return null;
                  },
                  onChanged: (descricao){
                    barbearia.descricao = descricao;
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
                  controller: _cidade,
                  validator: (value) {
                    if(value.isEmpty){
                      return 'Este campo é obrigatório';
                    }
                    return null;
                  },
                  onChanged: (cidade){
                    barbearia.cidade = cidade;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(FontAwesomeIcons.home),
                    hasFloatingPlaceholder: true,
                    hintText: "Logradouro"
                  ),
                  controller: _logradouro,
                  validator: (value) {
                    if(value.isEmpty){
                      return 'Este campo é obrigatório';
                    }
                    return null;
                  },
                  onChanged: (logradouro){
                    barbearia.endereco = logradouro;
                  },
                ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Selecione a sigla do seu estado", 
                      style: TextStyle(fontWeight: FontWeight.bold)),
                      new DropdownButton<Estados>(
                      iconEnabledColor: Colors.red,
                      value: _estado,
                      onChanged: (Estados newValue) {
                        setState(() {
                          barbearia.estado = newValue;
                          _estado = newValue;
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
                      child: Text("Horario de abertura")
                    ),
                    Expanded(
                      child: new DropdownButton<int>(
                        value: _horaAbertura,
                        onChanged: (int newValue){
                          setState((){
                            _horaAbertura = newValue;
                            barbearia.horaAbertura= newValue;
                          });
                        },
                        items: _horas.map((int _valueAbertura) {
                        return new DropdownMenuItem<int>(
                          value: _valueAbertura,
                          child: new Text(_valueAbertura.toString()));
                        }).toList()
                        )
                      ),
                      Expanded(child: new DropdownButton<int>(
                        value: _minutoAbertura,
                        onChanged: (int newValue){
                          setState((){
                            _minutoAbertura = newValue;
                            barbearia.minutoAbertura = newValue;
                          });
                        },
                        items: _minutos.map((int _valueFechamento) {
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
                        value: _horaFechamento,
                        onChanged: (int newValue){
                          setState((){
                            _horaFechamento = newValue;
                            barbearia.horaFechamento = newValue;
                          });
                        },
                        items: _horas.map((int _value) {
                        return new DropdownMenuItem<int>(
                          value: _value,
                          child: new Text(_value.toString()));
                        }).toList()
                        )
                      ),
                      Expanded(child: new DropdownButton<int>(
                        value: _minutoFechamento,
                        onChanged: (int newValue){
                          setState((){
                            _minutoFechamento = newValue;
                            barbearia.minutoFechamento = newValue;
                          });
                        },
                        items: _minutos.map((int _value) {
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
                        child: Text("Cadastrar"), 
                        key: Key("_submitButton"),
                        onPressed: () async {  
                          Barbearia responseBarbearia =  await _saveBarbearia(barbearia, widget.loggedUser);
                          if(responseBarbearia.id != null){
                          responseBarbearia.servicos = new List<Servico>();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => new PaginaBarbearia(barbearia: responseBarbearia, loggedUser: widget.loggedUser, open: false, sucesso: true, mensagem: "Cadastro Efetuado com sucesso")));
                          } else {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => new CadastroBarbearia(sucesso: false, open: false, mensagem: "Ops, algo deu errado, por favor, faça seu cadastro novamente",loggedUser: widget.loggedUser,)));
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
      ),
      ),
    );
  }
}

Future<Barbearia> _saveBarbearia(Barbearia barbearia, User user) async{
  List<Barbeiro> barbeiros = new List<Barbeiro>();
  barbeiros.add((user.barbeiro));
  barbearia.barbeiros = barbeiros;
  Future<Barbearia> fBarbearia = BarbeariaApi.saveBarbearia(barbearia);
  Barbearia responseBarbearia = await fBarbearia;
  return responseBarbearia;

}

Widget _loadMensagemDeErro(String mensagem){
  return Text(mensagem, style: TextStyle(backgroundColor: Colors.red, color: Colors.white),);
}