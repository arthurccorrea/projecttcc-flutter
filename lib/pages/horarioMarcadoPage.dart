import 'package:appbarbearia_flutter/api/HorarioMarcadoApi.dart';
import 'package:appbarbearia_flutter/main.dart';
import 'package:appbarbearia_flutter/model/HorarioMarcado.dart';
import 'package:appbarbearia_flutter/model/User.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HorarioMarcadoPage extends StatefulWidget {
  final HorarioMarcado horarioMarcado;
  final User loggedUser;

  const HorarioMarcadoPage({this.horarioMarcado, this.loggedUser});

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
                      widget.horarioMarcado.barbearia.nome,
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
                    onPressed: () async {
                      bool cancelado = await HorarioMarcadoApi.cancelarHorario(widget.horarioMarcado);
                      if(cancelado) {
                        List<HorarioMarcado> horariosMarcados = await HorarioMarcadoApi.findHorarioMarcadoByUser(widget.loggedUser);
                        Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => new HomePage(open: false, sucesso: true, mensagem: "Horario cancelado com sucesso", user: widget.loggedUser, horariosMarcados: horariosMarcados,)));
                      }
                    },
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
