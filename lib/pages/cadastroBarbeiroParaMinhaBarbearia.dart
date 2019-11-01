import 'package:appbarbearia_flutter/api/BarbeiroApi.dart';
import 'package:appbarbearia_flutter/api/HorarioMarcadoApi.dart';
import 'package:appbarbearia_flutter/main.dart';
import 'package:appbarbearia_flutter/model/Barbearia.dart';
import 'package:appbarbearia_flutter/model/Barbeiro.dart';
import 'package:appbarbearia_flutter/model/Estados.dart';
import 'package:appbarbearia_flutter/model/HorarioMarcado.dart';
import 'package:appbarbearia_flutter/model/User.dart';
import 'package:appbarbearia_flutter/model/UserBarbeiroWrapper.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class CadastroBarbeiroParaMinhaBarbearia extends StatefulWidget {
  final Barbearia barbearia;
  final User loggedUser;
  
  const CadastroBarbeiroParaMinhaBarbearia({this.barbearia, this.loggedUser});

  @override
  _CadastroBarbeiroParaMinhaBarbeariaState createState() => _CadastroBarbeiroParaMinhaBarbeariaState();
}

class _CadastroBarbeiroParaMinhaBarbeariaState extends State<CadastroBarbeiroParaMinhaBarbearia> {
  var _eFoto = TextEditingController();
  var _nome = TextEditingController();
  var _cpf = new MaskedTextController(mask: '000.000.000-00');
  DateFormat dateFormat = new DateFormat("yyyy-MM-dd");
  var _dataNascimento = new MaskedTextController(mask: '00/00/0000');
  var _cidade = TextEditingController();
  var _logradouro = TextEditingController();
  var _eUsername = TextEditingController();
  var _ePassword = TextEditingController();
  var _eTelefone = MaskedTextController(mask: '(00) 0000-0000');
  var _eCelular = MaskedTextController(mask: '(00) 00000-0000');
  Estados _estado = Estados.AC;
  Barbeiro _barbeiro = new Barbeiro();
  User _user = new User();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Barbeiro para barbearia")),
      body: Container(
        child: Form(
          key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(FontAwesomeIcons.image),
                hasFloatingPlaceholder: true,
                hintText: "Coloque uma foto sua"
              ),
              controller: _eFoto,
              onChanged: (foto) {
                _barbeiro.foto = foto;
              },
            ),
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
                hintText: "Digite seu email (*)",
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
                hintText: "Digite sua senha (*)",
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
                    icon: Icon(FontAwesomeIcons.image),
                    hasFloatingPlaceholder: true,
                    hintText: "Coloque uma foto"
                  ),
                  controller: _nome,
                  onChanged: (foto) {
                    _barbeiro.foto = foto;
                  },
                ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hasFloatingPlaceholder: true,
                hintText: "Insira o nome (*)"
              ),
              controller: _nome,
              validator: (value) {
                if(value.isEmpty){
                  return 'Este campo é obrigatório';
                }
                return null;
              },
              onChanged: (nome){
                _barbeiro.nome=nome;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hasFloatingPlaceholder: true,
                hintText: "Insira o seu CPF (*)"
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
                _barbeiro.cpf=cpf;
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
                    icon: Icon(Icons.map),
                    hasFloatingPlaceholder: true,
                    hintText: "Cidade (*)"
                  ),
                  validator: (value) {
                    if(value.isEmpty){
                      return 'Este campo é obrigatório';
                    }
                    return null;
                  },
                  controller: _cidade,
                  onChanged: (cidade){
                    _barbeiro.cidade=cidade;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(FontAwesomeIcons.home),
                    hasFloatingPlaceholder: true,
                    hintText: "Logradouro (*)"
                  ),
                  controller: _logradouro,
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
                      value: _estado,
                      onChanged: (Estados newValue) {
                        setState(() {
                          _barbeiro.estado=newValue;
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
                            Future<Barbeiro> fBarbeiro = _saveBarbeiroParaBarbearia(_user, _barbeiro, widget.barbearia);
                            Barbeiro responseBarbeiro = await fBarbeiro;
                            if(responseBarbeiro.id != null){
                              List<HorarioMarcado> horariosMarcados = await HorarioMarcadoApi.findHorarioMarcadoByUser(widget.loggedUser);
                              Navigator.push(
                                context, MaterialPageRoute(builder: (BuildContext context) => HomePage(horariosMarcados: horariosMarcados, mensagem: "Barbeiro para sua barbearia foi cadastrado com sucesso", open: false, sucesso: true, user: widget.loggedUser,)));
                            } else {
                              Text("Algo deu errado, por favor confira se todos os campos foram preenchidos", style: TextStyle(color: Colors.white, backgroundColor: Colors.red),);
                            }
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
    )
    )
    );
  }

  Future<Barbeiro> _saveBarbeiroParaBarbearia(User user, Barbeiro barbeiro, barbearia) async{
    barbeiro.barbearia = barbearia;
    UserBarbeiroWrapper barbeiroWrapper = new UserBarbeiroWrapper();
    barbeiroWrapper.barbeiro = barbeiro;
    barbeiroWrapper.user = user;
    Future<Barbeiro> fBarbeiro = BarbeiroApi.saveBarbeiroParaBarbearia(barbeiroWrapper);
    Barbeiro responseBarbeiro = await fBarbeiro;
    return responseBarbeiro;
  }
}