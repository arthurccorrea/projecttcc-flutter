import 'package:appbarbearia_flutter/api/HorarioApi.dart';
import 'package:appbarbearia_flutter/model/Barbearia.dart';
import 'package:appbarbearia_flutter/model/Barbeiro.dart';
import 'package:appbarbearia_flutter/model/Horario.dart';
import 'package:appbarbearia_flutter/model/User.dart';
import 'package:appbarbearia_flutter/pages/marcarHorario.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class HorariosBarbearia extends StatefulWidget {
  final Barbearia barbearia;
  final User loggedUser;
  final List<Horario> horariosBarbearia;
  final DateTime data;
  final bool minhaBarbearia;

  const HorariosBarbearia(
      {this.barbearia, this.loggedUser, this.horariosBarbearia, this.data, this.minhaBarbearia});

  @override
  _HorariosBarbeariaState createState() => _HorariosBarbeariaState();
}

class _HorariosBarbeariaState extends State<HorariosBarbearia> {
  var _dataNascimento = new MaskedTextController(mask: '00/00/0000');
  DateFormat dateFormat = DateFormat("HH:mm");
  DateFormat dateFormatApenasDia = DateFormat("dd/MM");
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  DateTime _data;
  Barbeiro _barbeiro;

  @override
  void initState() {
    _barbeiro = widget.barbearia.barbeiros[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Horarios"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            DateTimePickerFormField(
              // TODO: ADICIONAR VALIDATOR PRA NÃO DEIXAR PROCURAR SEM DATA
                firstDate: DateTime.now(),
                dateOnly: true,
                inputType: InputType.date,
                editable: false,
                format: DateFormat("dd/MM/yyyy"),
                keyboardType: TextInputType.datetime,
                controller: _dataNascimento,
                decoration: InputDecoration(
                  fillColor: Colors.redAccent,
                  labelText: 'Data que deseja ver os horários',
                  // hasFloatingPlaceholder: true,
                  icon: Icon(Icons.calendar_today),
                ),
                onChanged: (data) async {
                  _data = data;
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Selecione o barbeiro",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                new DropdownButton<Barbeiro>(
                    iconEnabledColor: Colors.red,
                    value: _barbeiro,
                    onChanged: (Barbeiro newValue) {
                      setState(() {
                        _barbeiro = newValue;
                      });
                    },
                    items: widget.barbearia.barbeiros.map((Barbeiro _barbeiro) {
                      return new DropdownMenuItem<Barbeiro>(
                          value: _barbeiro, child: new Text(_barbeiro.nome));
                    }).toList())
              ],
            ),
            ButtonTheme(
              minWidth: double.infinity,
              child: RaisedButton(
                child: Text("Procurar"),
                key: Key("_searchButton"),
                onPressed: () async {
                  List<Horario> _horariosBarbearia =
                      await _listaHorariosDisponiveisPorData(
                          _data, _barbeiro);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new HorariosBarbearia(
                                barbearia: widget.barbearia,
                                loggedUser: widget.loggedUser,
                                horariosBarbearia: _horariosBarbearia,
                                data: _data,
                                minhaBarbearia: widget.minhaBarbearia
                              )));
                },
                elevation: 3.0,
                //color: Colors.purple,
                textColor: Colors.white,
              ),
            ),
            widget.data != null
                ? Text(dateFormatApenasDia.format(widget.data))
                : Text(""),
            Divider(),
            for (var horario in widget.horariosBarbearia)
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new MarcarHorario(
                            barbearia: widget.barbearia,
                            horario: horario,
                            data: widget.data,
                            minhaBarbearia: widget.minhaBarbearia,
                            cliente: widget.loggedUser.cliente == null ? null : widget.loggedUser.cliente,
                            barbeiro: _barbeiro,
                            loggedUser: widget.loggedUser,
                          )));
                },
                child: Card(
                  child: Row(
                    children: <Widget>[Text(dateFormat.format(horario.hora))],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

Future<List<Horario>> _listaHorariosDisponiveisPorData(
    DateTime data, Barbeiro barbeiro) async {
  List<Horario> horarios =
      await HorarioApi.getHorariosDisponiveisBarbearia(data, barbeiro);
  return horarios;
}
