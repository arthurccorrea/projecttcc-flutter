import 'dart:io';

import 'package:appbarbearia_flutter/api/AuthApiService.dart';
import 'package:appbarbearia_flutter/pages/cadastroBarbearia.dart';
import 'package:appbarbearia_flutter/pages/cadastroCliente.dart';
import 'package:appbarbearia_flutter/pages/form_marcarHorario.dart';
import 'package:appbarbearia_flutter/pages/listagemBarbearia.dart';
import 'package:appbarbearia_flutter/pages/loginPage.dart';
import 'package:appbarbearia_flutter/pages/pagina_teste.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

AuthApiService appAuth = new AuthApiService();
String token;

void main() async {
  Widget _defaultHome = new LoginPage();
  File tokenFile = await appAuth.localFile;
  token = tokenFile.readAsStringSync();
  if (token != null && token.isNotEmpty) {
    bool response = await appAuth.validarToken(token);
    if(response) {
      _defaultHome = HomePage();
    }
  }

  // Run app!
  runApp(new MaterialApp(
    title: 'App',
    home: _defaultHome,
    routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      '/home': (BuildContext context) => new HomePage(),
      '/login': (BuildContext context) => new LoginPage()
    },
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext buildContext){
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: new HomePage(),
      // routes: <String, WidgetBuilder>{
      //   "/a": (BuildContext buildContext)=> NewPage("T E S T A N D O"),
      // }
      );
  }
}

class HomePage extends StatelessWidget {
   @override
   Widget build(BuildContext buildContext){
     return new Scaffold(
       appBar: new AppBar(
         title: new Text("Yeeeeeeeeeeeeeeeeeeet"),
         elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
       ),
       drawer: new Drawer(
         child: new ListView(
           children: <Widget>[
             new UserAccountsDrawerHeader(
               accountName: new Text("João Douglas"),
               accountEmail: new Text("joaodouglas@mail.com"),
               currentAccountPicture: new CircleAvatar(
                 backgroundColor: Colors.black38,
                 child: new Text("JD"),
               ),
             ),
             new ListTile(
               title: new Text("Eu"),
               trailing: new Icon(Icons.arrow_back),
               onTap: () {
                Navigator.of(buildContext).pop();
                Navigator.of(buildContext).push(new MaterialPageRoute(
                  builder: (BuildContext context)=> 
                    new FutureTest()));
               },
             ),
             new ListTile(
               title: new Text("Não"),
               trailing: new Icon(Icons.add_shopping_cart),
               onTap:(){
                 Navigator.of(buildContext).pop();
                 Navigator.of(buildContext).push(new MaterialPageRoute(
                   builder: (BuildContext context)=>
                    new HorarioMarcadoForm()));
               },
             ),
             new ListTile(
               title: new Text("Listagem barberias"),
               trailing: new Icon(Icons.accessibility),
               onTap:(){
                 Navigator.of(buildContext).pop();
                 Navigator.of(buildContext).push(new MaterialPageRoute(
                   builder: (BuildContext context)=>
                  new ListagemBarbearia())
                 );
               },
             ),
             new ListTile(
               title: new Text("Cadastro de cliente"),
               trailing: new Icon(Icons.accessibility),
               onTap:(){
                 Navigator.of(buildContext).pop();
                 Navigator.of(buildContext).push(new MaterialPageRoute(
                   builder: (BuildContext context)=>
                    new CadastroCliente())
                 );
               },
             ),
             new ListTile(
               title: new Text("Cadastro de barbearia"),
               trailing: new Icon(Icons.accessibility),
               onTap:(){
                 Navigator.of(buildContext).pop();
                 Navigator.of(buildContext).push(new MaterialPageRoute(
                   builder: (BuildContext context)=>
                    new CadastroBarbearia())
                 );
               },
             ),
             new Divider(),
             new ListTile(
               title: new Text("Fecha essa barra que não faz nada"),
               trailing: new Icon(Icons.close),
             ), 
           ],
         ),
       ),
       body: new Container(
         child: new Center(
           child: new Text("Home page"),
         ),
       ),
     );
   }
}