import 'package:appbarbearia_flutter/model/HorarioMarcado.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HorarioMarcadoForm extends StatefulWidget{

  @override
  _HorarioMarcadoPage createState() => _HorarioMarcadoPage();

}

class _HorarioMarcadoPage extends State<HorarioMarcadoForm> {
  final _horarioMarcado = HorarioMarcado();
  final _formKey = GlobalKey<FormState>();
  // final List<Horario> _horario = new List<Horario>();
  var list = ["one", "two", "three", "four"]; 

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    // final format = DateFormat("yyyy-MM-dd HH:mm");
    return Scaffold(
      appBar: AppBar( title: Text("Horario Marcado")),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(builder: (context) => Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.lightBlue,
                  
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5)
                ),
                DateTimePickerFormField(
                  dateOnly: true,
                  inputType: InputType.date,
                  editable: false, 
                  format: DateFormat("dd/MM/yyyy"),
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(Duration(days: 1)),
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    fillColor: Colors.redAccent,
                    labelText: 'Data',
                    border: OutlineInputBorder(),
                    hasFloatingPlaceholder: false
                  ),
                    onChanged: (dt) {
                      _horarioMarcado.dia = dt;
                      Text(DateFormat("dd-MM-yyyy").format(_horarioMarcado.dia));
                      // print(DateFormat("dd-MM-yyyy").format(_horarioMarcado.dia));
                      
                    }
                ),
                for(var x in list) Text(x)
              ],
            ),
          ),
        ),
      ),
    );
  }
}