import 'package:appbarbearia_flutter/api/ClienteApi.dart';
import 'package:appbarbearia_flutter/model/Cliente.dart';
import 'package:appbarbearia_flutter/model/Estados.dart';
import 'package:appbarbearia_flutter/model/User.dart';
import 'package:appbarbearia_flutter/model/UserClienteWrapper.dart';
import 'package:appbarbearia_flutter/pages/loginPage.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CadastroCliente extends StatefulWidget {

  final sucesso;
  final Cliente cliente;

  const CadastroCliente({Key key, this.sucesso, this.cliente}): super(key: key);

  @override
  _CadastroClienteState createState() => _CadastroClienteState();
}

class _CadastroClienteState extends State<CadastroCliente> {

  var _nome = TextEditingController();
  var _cpf = new MaskedTextController(mask: '000.000.000-00');
  // DateTime _dataNascimento;
  DateFormat dateFormat = new DateFormat("yyyy-MM-dd");
  var _dataNascimento = new MaskedTextController(mask: '00/00/0000');
  var _cidade = TextEditingController();
  var _logradouro = TextEditingController();
  var _eUsername = TextEditingController();
  var _ePassword = TextEditingController();
  var _eTelefone = MaskedTextController(mask: '(00) 0000-0000');
  var _eCelular = MaskedTextController(mask: '(00) 00000-0000');
  Estados _estado = Estados.AC;
  Cliente _cliente = new Cliente();
  User _user = new User();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro de cliente")),
      body: Container(
        child: Form(
          key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              validator: (value) {
                if(value.isEmpty){
                  return 'Este campo é obrigatório';
                }
                return null;
              },
              decoration: const InputDecoration(
                icon: Icon(Icons.mail),
                hasFloatingPlaceholder: true,
                hintText: "Digite seu email",
              ),
              controller: _eUsername,
              onChanged: (username) {
                _user.username = username;
              },
            ),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Digite sua senha",
                icon: Icon(Icons.vpn_key),
              ),
              validator: (value) {
                if(value.isEmpty){
                  return 'Este campo é obrigatório';
                }
                return null;
              },
              controller: _ePassword,
              onChanged: (password) {
                _user.password = password;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hasFloatingPlaceholder: true,
                hintText: "Insira o nome"
              ),
              controller: _nome,
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
                hintText: "Insira o seu CPF"
              ),
              controller: _cpf,
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
                  controller: _dataNascimento,
                  decoration: InputDecoration(
                    fillColor: Colors.redAccent,
                    labelText: 'Data nascimento',
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
                    hintText: "Cidade"
                  ),
                  validator: (value) {
                    if(value.isEmpty){
                      return 'Este campo é obrigatório';
                    }
                    return null;
                  },
                  controller: _cidade,
                  onChanged: (cidade){
                    _cliente.cidade=cidade;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.landscape),
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
                      hintText: "Telefone"
                  ),
                  keyboardType: TextInputType.number,
                  controller: _eCelular,
                  validator: (value) {
                    if(value.isEmpty){
                      return 'Este campo é obrigatório';
                    }
                    return null;
                  },
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
                      value: _estado,
                      
                    onChanged: (Estados newValue) {
                      setState(() {
                        _cliente.estado=newValue;
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
                 Row(
                    children: <Widget>[
                      Expanded(
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      child: RaisedButton(
                        child: Text("Cadastrar"), 
                        key: Key("_submitButton"),
                        onPressed: () async{
                          if (_formKey.currentState.validate()) {
                            Future<Cliente> fCliente = _saveCliente(_user, _cliente);
                            Cliente responseCliente = await fCliente;
                            if(responseCliente.id != null){
                              Navigator.push(
                                context, MaterialPageRoute(builder: (BuildContext context) => LoginPage(sucesso: true,)));
                            } else {
                              SnackBar(
                                content: Text("Algo deu errado, por favor confira se todos os campos foram preenchidos"),
                                duration: Duration(seconds: 15),
                              );
                           }
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
          ],
      ),
    )
    )
    );
  }

  Future<Cliente> _saveCliente(User user, Cliente cliente) async{
    UserClienteWrapper clienteWrapper = new UserClienteWrapper();
    clienteWrapper.cliente = cliente;
    clienteWrapper.user = user;
    Future<Cliente> fCliente = ClienteApi.saveCliente(clienteWrapper);
    Cliente responseCliente = await fCliente;
    return responseCliente;
  }
}
