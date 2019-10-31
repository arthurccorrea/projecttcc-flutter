import 'package:appbarbearia_flutter/api/BarbeiroApi.dart';
import 'package:appbarbearia_flutter/model/Barbeiro.dart';
import 'package:appbarbearia_flutter/model/Cliente.dart';
import 'package:appbarbearia_flutter/model/Estados.dart';
import 'package:appbarbearia_flutter/model/User.dart';
import 'package:appbarbearia_flutter/model/UserBarbeiroWrapper.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

import 'minhaBarbearia.dart';

abstract class EditarBarbeiro extends StatefulWidget{
  final Barbeiro barbeiro;
  final Cliente cliente;
  final User loggedUser;

  const EditarBarbeiro({Key key, this.cliente, this.loggedUser, this.barbeiro}) : super(key: key);
  
  @override
  _EditarBarbeiroState createState() => _EditarBarbeiroState();  
}

class _EditarBarbeiroState extends State<EditarBarbeiro> {
  Barbeiro _barbeiro;
  var _eNome;
  var _eCpf;
  var _eDataNascimento;
  var _eCidade;
  var _eLogradouro;
  var _eTelefone;
  var _eCelular;
  Estados _eEstado = Estados.AC;
  final _formKey = GlobalKey<FormState>();
  DateFormat dateFormat = new DateFormat("yyyy-MM-dd");

  @override
  void initState() {
    _eNome = TextEditingController(text: widget.cliente.nome);
    _eCpf = new MaskedTextController(mask: '000.000.000-00', text: widget.cliente.cpf);
    _eDataNascimento = new MaskedTextController(mask: '00/00/0000', text: widget.cliente.dataNascimento.toString());
    _eCidade = TextEditingController(text: widget.cliente.cidade);
    _eLogradouro = TextEditingController(text: widget.cliente.endereco);
    _eTelefone = MaskedTextController(mask: '(00) 0000-0000', text: widget.cliente.telefone);
    _eCelular = MaskedTextController(mask: '(00) 0000-0000', text: widget.cliente.celular);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: new AppBar(
      title: Text("Editando Usuario"),
    ),
    body: Container(
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
          TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hasFloatingPlaceholder: true,
                hintText: "Insira o nome (*)"
              ),
              controller: _eNome,
              validator: (value) {
                if(value.isEmpty){
                  return 'Este campo é obrigatório';
                }
                return null;
              },
              onChanged: (nome){
                _barbeiro.nome = nome;
              },
            ),  
             TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hasFloatingPlaceholder: true,
                hintText: "Insira o seu CPF (*)"
              ),
              controller: _eCpf,
              keyboardType: TextInputType.number,
              validator: (value) {
                if(value.isEmpty){
                  return 'Este campo é obrigatório';
                }
                return null;
              },
              onChanged: (cpf){
                _barbeiro.cpf=cpf;
              },              
            ),
            DateTimePickerFormField(
                  dateOnly: true,
                  inputType: InputType.date,
                  editable: false, 
                  format: DateFormat("dd/MM/yyyy"),
                  keyboardType: TextInputType.datetime,
                  controller: _eDataNascimento,
                  decoration: InputDecoration(
                    fillColor: Colors.redAccent,
                    labelText: 'Data nascimento (*)',
                    hasFloatingPlaceholder: true,
                    icon: Icon(Icons.calendar_today),
                  ),
                  validator: (value) {
                    if(value == null){
                      return 'Este campo é obrigatório';
                    }
                    return null;
                  },
                  onChanged: (dt) {
                    _barbeiro.dataNascimento=dt;
                    Text(DateFormat("dd-MM-yyyy").format(dt));
                  }
                ),
             Divider(),
             Align(
                  alignment: Alignment.center,
                  child: Text("ENDERECO"),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.location_city),
                    hasFloatingPlaceholder: true,
                    hintText: "Cidade (*)"
                  ),
                  validator: (value) {
                    if(value.isEmpty){
                      return 'Este campo é obrigatório';
                    }
                    return null;
                  },
                  controller: _eCidade,
                  onChanged: (cidade){
                    _barbeiro.cidade=cidade;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.landscape),
                    hasFloatingPlaceholder: true,
                    hintText: "Logradouro (*)"
                  ),
                  controller: _eLogradouro,
                  validator: (value) {
                    if(value.isEmpty){
                      return 'Este campo é obrigatório';
                    }
                    return null;
                  },
                  onChanged: (endereco){
                    _barbeiro.endereco=endereco;
                  },
                ),
                Divider(),
                Align(
                  alignment: Alignment.center,
                  child: Text("CONTATO"),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      icon: Icon(Icons.phone),
                      hasFloatingPlaceholder: true,
                      hintText: "Telefone",
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if(value.isEmpty){
                      return 'Este campo é obrigatório';
                    }
                    return null;
                  },
                  controller: _eTelefone,
                  onChanged: (telefone){
                    _barbeiro.telefone=telefone;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      icon: Icon(Icons.phone_iphone),
                      hasFloatingPlaceholder: true,
                      hintText: "Celular (*)"
                  ),
                  keyboardType: TextInputType.number,
                  controller: _eCelular,
                  onChanged: (celular){
                    _barbeiro.celular=celular;
                  },
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
                          _barbeiro.estado=newValue;
                          _eEstado = newValue;
                        });
                      },
                    items: Estados.values.map((Estados _estado) {
                      return new DropdownMenuItem<Estados>(
                        value: _estado,
                        child: new Text(_estado.toString().replaceAll("Estados.", "")));
                    }).toList()
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
                          Barbeiro responseBarbeiro =
                              await _saveBarbeiro(_eNome, _barbeiro);
                          if (responseBarbeiro != null &&
                              responseBarbeiro.id != null) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new MinhaBarbearia(                                         
                                          loggedUser: widget.loggedUser,
                                          sucesso: true,
                                          open: false,
                                          mensagem:
                                              "Usuario alterado com sucesso!",
                                        )));
                          } else {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new MinhaBarbearia(                                            
                                            loggedUser: widget.loggedUser,
                                            sucesso: false,
                                            open: false,
                                            mensagem:
                                                "Algo deu errado na alteração do Usuario!")));
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
          ),
          ]
   )
    ),
    ),
    );
  }
    Future<Barbeiro> _saveBarbeiro(User user, Barbeiro barbeiro) async{
    UserBarbeiroWrapper barbeiroWrapper = new UserBarbeiroWrapper();
    barbeiroWrapper.barbeiro = barbeiro;
    barbeiroWrapper.user = user;
    Future<Barbeiro> fBarbeiro = BarbeiroApi.saveBarbeiro(barbeiroWrapper);
    Barbeiro responseBarbeiro = await fBarbeiro;
    return responseBarbeiro;
  }
    
  
  }
