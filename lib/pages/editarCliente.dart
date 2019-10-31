import 'package:appbarbearia_flutter/api/ClienteApi.dart';
import 'package:appbarbearia_flutter/api/HorarioMarcadoApi.dart';
import 'package:appbarbearia_flutter/model/Cliente.dart';
import 'package:appbarbearia_flutter/model/Estados.dart';
import 'package:appbarbearia_flutter/model/HorarioMarcado.dart';
import 'package:appbarbearia_flutter/model/User.dart';
import 'package:appbarbearia_flutter/model/UserClienteWrapper.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class EditarCliente extends StatefulWidget{
  final Cliente cliente;
  final User loggedUser;

  const EditarCliente({this.loggedUser, this.cliente});

  @override
  _EditarClienteState createState() => _EditarClienteState();
}

class _EditarClienteState extends State<EditarCliente> {
  Cliente _cliente;
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
    _cliente = widget.cliente;
    DateFormat formataDataNascimento = new DateFormat("dd/MM/yyyy");
    _eNome = TextEditingController(text: widget.cliente.nome);
    _eCpf = new MaskedTextController(
        mask: '000.000.000-00', text: widget.cliente.cpf);
    _eDataNascimento = new MaskedTextController(
        mask: '00/00/0000', text: formataDataNascimento.format(widget.cliente.dataNascimento));
    _eCidade = TextEditingController(text: widget.cliente.cidade);
    _eLogradouro = TextEditingController(text: widget.cliente.endereco);
    _eTelefone = MaskedTextController(
        mask: '(00) 0000-0000', text: widget.cliente.telefone);
    _eCelular = MaskedTextController(
        mask: '(00) 00000-0000', text: widget.cliente.celular);
    _eEstado = widget.cliente.estado;
    super.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: new AppBar(
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
                _cliente.nome=nome;
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
                _cliente.cpf=cpf;
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
                    _cliente.dataNascimento=dt;
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
                    _cliente.cidade=cidade;
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
                    _cliente.endereco=endereco;
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
                    _cliente.telefone=telefone;
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
                    _cliente.celular=celular;
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
                          _cliente.estado=newValue;
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
              Row(
                children: <Widget>[
                      Expanded(
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      child: RaisedButton(
                        child: Text("Editar"), 
                        key: Key("_submitButton"),
                        onPressed: () async{
                          if (_formKey.currentState.validate()) {
                            Future<Cliente> fCliente = _saveCliente(widget.loggedUser, _cliente);
                            Cliente responseBarbeiro = await fCliente;
                            if(responseBarbeiro.id != null){
                              List<HorarioMarcado> horariosMarcados = await HorarioMarcadoApi.findHorarioMarcadoByUser(widget.loggedUser);
                              Navigator.push(
                                context, MaterialPageRoute(builder: (BuildContext context) => HomePage(horariosMarcados: horariosMarcados, mensagem: "Seu perfil foi editado com sucesso!" ,user: widget.loggedUser, sucesso: false, open: false)));
                            } else {
                              Text("Algo deu errado, por favor confira se todos os campos foram preenchidos", style: TextStyle(color: Colors.white, backgroundColor: Colors.red),);
                            }
                          }
                        },
                        elevation: 3.0,
                        //color: Colors.purple,
                        textColor: Colors.white,      
                      )
                    )
                  )
            ],
          ),
            ]
        ),
      ),
    ));    
  }
  Future<Cliente> _saveCliente(User user, Cliente cliente) async {
    UserClienteWrapper clienteWrapper = new UserClienteWrapper();
    clienteWrapper.cliente = cliente;
    clienteWrapper.user = user;
    Future<Cliente> fCliente = ClienteApi.saveCliente(clienteWrapper);
    Cliente responseCliente = await fCliente;
    return responseCliente;
  }
}