import 'package:appbarbearia_flutter/api/BarbeariaApi.dart';
import 'package:appbarbearia_flutter/model/Barbearia.dart';
import 'package:appbarbearia_flutter/model/Estados.dart';
import 'package:flutter/material.dart';

class CadastroBarbearia extends StatefulWidget {
  @override
  _CadastroBarbeariaState createState() => _CadastroBarbeariaState();
}

class _CadastroBarbeariaState extends State<CadastroBarbearia> {
  Barbearia barbearia = new Barbearia();
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

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text("Cadastre sua barbearia")),
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
                    barbearia.setNome(_nome.text);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.content_paste),
                    hasFloatingPlaceholder: true,
                    hintText: "Descreva a sua barbearia"
                  ),
                  controller: _descricao,
                  onEditingComplete: (){
                    barbearia.setDescricao(_descricao.text);
                  },
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
                  onEditingComplete: (){
                    barbearia.setCidade(_cidade.text);
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
                    barbearia.setEndereco(_logradouro.text);
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
                          barbearia.setEstado(newValue);
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
                            barbearia.setHoraAbertura(newValue);
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
                            barbearia.setMinutoAbertura(newValue);
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
                            barbearia.setHoraFechamento(newValue);
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
                            barbearia.setMinutoFechamento(newValue);
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
                        onPressed: (){  
                          BarbeariaApi.saveBarbearia(barbearia);
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
      ),
    );
  }
}