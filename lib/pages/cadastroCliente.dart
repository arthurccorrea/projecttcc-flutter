import 'package:appbarbearia_flutter/api/ClienteApi.dart';
import 'package:appbarbearia_flutter/model/Estados.dart';
import 'package:appbarbearia_flutter/model/UserClienteWrapper.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CadastroCliente extends StatefulWidget {
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
  Estados _estado = Estados.AC;

  UserClienteWrapper clienteWrapper = new UserClienteWrapper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro de cliente")),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hasFloatingPlaceholder: true,
                hintText: "Insira o nome"
              ),
              controller: _nome,
              onEditingComplete: (){
                clienteWrapper.cliente.setNome(_nome.text);
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
              onChanged: (cpf){
                clienteWrapper.cliente.setCpf(cpf);
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
                    onChanged: (dt) {
                      clienteWrapper.cliente.setDataNascimento(dt);
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
                  controller: _cidade,
                  onChanged: (cidade){
                    clienteWrapper.cliente.setCidade(cidade);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.landscape),
                    hasFloatingPlaceholder: true,
                    hintText: "Logradouro"
                  ),
                  controller: _logradouro,
                  onEditingComplete: (){
                    clienteWrapper.cliente.setEndereco(_logradouro.text);
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
                        clienteWrapper.cliente.setEstado(newValue);
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
                        onPressed: (){  
                          ClienteApi.saveCliente(clienteWrapper.cliente);
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
    );
  }
}