import 'package:appbarbearia_flutter/model/HorarioMarcado.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:intl/intl.dart';

class HorarioMarcadoPage extends StatefulWidget {
  final HorarioMarcado horarioMarcado;

  const HorarioMarcadoPage({this.horarioMarcado});

  @override
  _HorarioMarcadoState createState() => _HorarioMarcadoState();
}

class _HorarioMarcadoState extends State<HorarioMarcadoPage> {
  DateFormat dateFormat = new DateFormat("HH:mm");
  DateFormat dateFormatApenasDia = new DateFormat("dd/MM");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Horário marcado"),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: <Widget>[
            Wrap(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "Barbearia: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Text(
                      widget.horarioMarcado.barbeiro.barbearia.nome,
                      style: TextStyle(fontSize: 22),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Barbeiro: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(widget.horarioMarcado.barbeiro.nome),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Dia ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(dateFormatApenasDia.format(widget.horarioMarcado.dia) +
                        " as " +
                        dateFormat.format(widget.horarioMarcado.horario.hora)),
                  ],
                ),
                ButtonTheme(
                  minWidth: double.infinity,
                  child: RaisedButton(
                    child: Text("Cancelar horario"),
                    key: Key("_cancelarButton"),
                    onPressed: () async {},
                    elevation: 3.0,
                    color: Colors.red,
                    textColor: Colors.white,
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
