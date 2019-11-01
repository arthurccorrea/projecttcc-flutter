import 'package:appbarbearia_flutter/api/HorarioMarcadoApi.dart';
import 'package:appbarbearia_flutter/main.dart';
import 'package:appbarbearia_flutter/model/Barbearia.dart';
import 'package:appbarbearia_flutter/model/Barbeiro.dart';
import 'package:appbarbearia_flutter/model/Cliente.dart';
import 'package:appbarbearia_flutter/model/Horario.dart';
import 'package:appbarbearia_flutter/model/HorarioMarcado.dart';
import 'package:appbarbearia_flutter/model/Servico.dart';
import 'package:appbarbearia_flutter/model/User.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MarcarHorario extends StatefulWidget {
  final Barbearia barbearia;
  final Horario horario;
  final DateTime data;
  final Barbeiro barbeiro;
  final Cliente cliente;
  final bool minhaBarbearia;
  final User loggedUser;

  const MarcarHorario({this.barbearia, this.horario, this.data, this.barbeiro, this.cliente, this.minhaBarbearia, this.loggedUser});

  @override
  _MarcarHorarioState createState() => _MarcarHorarioState();
}

class _MarcarHorarioState extends State<MarcarHorario> {
  Servico _servico;
  DateFormat formatHora = new DateFormat("hh:mm");
  DateFormat formatDia = new DateFormat("dd/MM/yyyy");
  var _clienteNome = TextEditingController();
  HorarioMarcado _horarioMarcado = new HorarioMarcado();

   @override
  void initState() {
    _servico = widget.barbearia.servicos[0];
    if(widget.loggedUser.barbeiro != null && !widget.minhaBarbearia) {
    _horarioMarcado.barbeiroComoCliente = widget.loggedUser.barbeiro;
    } else {
      _horarioMarcado.cliente = widget.cliente;
    }
    _horarioMarcado.barbeiro = widget.barbeiro;
    _horarioMarcado.dia = widget.data;
    _horarioMarcado.barbeiro = widget.barbeiro;
    _horarioMarcado.horario = widget.horario;
    _horarioMarcado.servico = _servico;
    _horarioMarcado.dia = widget.data;
    _horarioMarcado.barbearia = widget.barbearia;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marcar horário em " + widget.barbearia.nome),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Selecione o Serviço",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                new DropdownButton<Servico>(
                    iconEnabledColor: Colors.red,
                    value: _servico,
                    onChanged: (Servico newValue) {
                      setState(() {
                        _servico = newValue;
                        _horarioMarcado.servico = newValue;
                      });
                    },
                    items: widget.barbearia.servicos.map((Servico _servico) {
                      return new DropdownMenuItem<Servico>(
                          value: _servico, child: new Text(_servico.descricao));
                    }).toList())
              ],
            ),
            widget.minhaBarbearia ? TextFormField(
                  decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hasFloatingPlaceholder: true,
                      hintText: "Insira o nome do cliente"),
                  controller: _clienteNome,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Este campo é obrigatório';
                    }
                    return null;
                  },
                  onChanged: (clienteNome) {
                    _horarioMarcado.clienteNome = clienteNome;
                  },
                ) : Text(""),
            Row(
              children: <Widget>[
                Text("Barbeiro: " )
              ],
            ),
            Row(
              children: <Widget>[
                Text("Dia " + formatDia.format(widget.data)),
              ],
            ),
            Row(
              children: <Widget>[
                Text("Hora " + formatHora.format(widget.horario.hora)),
              ],
            ),
            Row(
              children: <Widget>[
                Text("Preço " + _servico.preco.toString().replaceAll(".", ",")),
              ],
            ),
            ButtonTheme(
              minWidth: double.infinity,
              child: RaisedButton(
                child: Text("Marcar horário"),
                key: Key("_searchButton"),
                onPressed: () async {
                  HorarioMarcado _horarioMarcadoResponse = await _salvarHorarioMarcado(_horarioMarcado);
                  if(_horarioMarcadoResponse.id != null) {
                    _horarioMarcadoResponse.barbeiro.barbearia = widget.barbearia;
                    List<HorarioMarcado> _horariosMarcados = await HorarioMarcadoApi.findHorarioMarcadoByUser(widget.loggedUser);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => new HomePage(horariosMarcados: _horariosMarcados, user: widget.loggedUser, mensagem: "Horario marcada para " + formatDia.format(_horarioMarcadoResponse.dia) + "as" + formatHora.format(_horarioMarcadoResponse.horario.hora), open: false, sucesso: true,)));
                  } else {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => new MarcarHorario(barbearia: widget.barbearia, barbeiro: widget.barbeiro, cliente: widget.cliente, data: widget.data, horario: widget.horario, minhaBarbearia: widget.minhaBarbearia,)));
                  }
                },
                elevation: 3.0,
                textColor: Colors.white,
              ),
            ),
            widget.minhaBarbearia ? ButtonTheme(
              minWidth: double.infinity,
              child: RaisedButton(
                child: Text("Marcar almoco!"),
                key: Key("_searchButton"),
                onPressed: () async {
                  HorarioMarcado _horarioMarcadoResponse = await _marcarHorarioAlmoco(_horarioMarcado);
                  if(_horarioMarcadoResponse.id != null) {
                    _horarioMarcadoResponse.barbeiro.barbearia = widget.barbearia;
                    List<HorarioMarcado> _horariosMarcados = await HorarioMarcadoApi.findHorarioMarcadoByUser(widget.loggedUser);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => new HomePage(horariosMarcados: _horariosMarcados, user: widget.loggedUser, mensagem: "Horario marcada para " + formatDia.format(_horarioMarcadoResponse.dia) + "as" + formatHora.format(_horarioMarcadoResponse.horario.hora), open: false, sucesso: true,)));
                  } else {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => new MarcarHorario(barbearia: widget.barbearia, barbeiro: widget.barbeiro, cliente: widget.cliente, data: widget.data, horario: widget.horario, minhaBarbearia: widget.minhaBarbearia,)));
                  }
                },
                elevation: 3.0,
                color: Colors.brown,
                textColor: Colors.white,
              ),
            ) : Text(""),
          ],
        ),
      ),
    );
  }
}

Future<HorarioMarcado> _salvarHorarioMarcado(HorarioMarcado horarioMarcado) async {
  Future<HorarioMarcado> fHorarioMarcado  = HorarioMarcadoApi.salvarHorarioMarcado(horarioMarcado);
  HorarioMarcado responseHorarioMarcado = await fHorarioMarcado;

  return responseHorarioMarcado;
}

Future<HorarioMarcado> _marcarHorarioAlmoco(HorarioMarcado horarioMarcado) async {
  HorarioMarcado responseHorarioMarcado = await HorarioMarcadoApi.salvarHorarioAlmoco(horarioMarcado);
  return responseHorarioMarcado;
}