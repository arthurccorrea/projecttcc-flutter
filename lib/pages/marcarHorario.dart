import 'package:appbarbearia_flutter/api/HorarioMarcadoApi.dart';
import 'package:appbarbearia_flutter/model/Barbearia.dart';
import 'package:appbarbearia_flutter/model/Barbeiro.dart';
import 'package:appbarbearia_flutter/model/Cliente.dart';
import 'package:appbarbearia_flutter/model/Horario.dart';
import 'package:appbarbearia_flutter/model/HorarioMarcado.dart';
import 'package:appbarbearia_flutter/model/Servico.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MarcarHorario extends StatefulWidget {
  final Barbearia barbearia;
  final Horario horario;
  final DateTime data;
  final Barbeiro barbeiro;
  final Cliente cliente;

  const MarcarHorario({this.barbearia, this.horario, this.data, this.barbeiro, this.cliente});

  @override
  _MarcarHorarioState createState() => _MarcarHorarioState();
}

class _MarcarHorarioState extends State<MarcarHorario> {
  Servico _servico;
  DateFormat formatHora = new DateFormat("hh:mm");
  DateFormat formatDia = new DateFormat("dd/MM/yyyy");
  HorarioMarcado _horarioMarcado = new HorarioMarcado();

   @override
  void initState() {
    _servico = widget.barbearia.servicos[0];
    _horarioMarcado.dia = widget.data;
    _horarioMarcado.barbeiro = widget.barbeiro;
    _horarioMarcado.cliente = widget.cliente;
    _horarioMarcado.horario = widget.horario;
    _horarioMarcado.dia = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marcar horário em " + widget.barbearia.nome),
      ),
      body: Container(
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
                  // TODO: ABRIR PAGINA DE HORARIO MARCADO => FAZER ELA
                },
                elevation: 3.0,
                color: Colors.purple,
                textColor: Colors.white,
              ),
            ),
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