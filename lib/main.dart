import 'dart:io';

import 'package:appbarbearia_flutter/api/AuthApiService.dart';
import 'package:appbarbearia_flutter/api/BarbeariaApi.dart';
import 'package:appbarbearia_flutter/api/HorarioMarcadoApi.dart';
import 'package:appbarbearia_flutter/model/Barbearia.dart';
import 'package:appbarbearia_flutter/model/HorarioMarcado.dart';
import 'package:appbarbearia_flutter/model/User.dart';
import 'package:appbarbearia_flutter/pages/cadastroBarbearia.dart';
import 'package:appbarbearia_flutter/pages/cadastroCliente.dart';
import 'package:appbarbearia_flutter/pages/form_marcarHorario.dart';
import 'package:appbarbearia_flutter/pages/listagemBarbearia.dart';
import 'package:appbarbearia_flutter/pages/loginPage.dart';
import 'package:appbarbearia_flutter/pages/minhaBarbearia.dart';
import 'package:appbarbearia_flutter/pages/pagina_teste.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

AuthApiService appAuth = new AuthApiService();
String token;

void main() async {
  Widget _defaultHome = new LoginPage(sucesso: true, open: true);
  bool loginSucedido = false;
  File tokenFile = await appAuth.localFile;
  token = tokenFile.readAsStringSync();
  User responseUser = new User();
  if (token != null && token.isNotEmpty) {
    bool response = await appAuth.validarToken(token);
    if (response) {
      String username = await authService.getLoggedUserUsername();
      Future<User> fUser = authService.getUserByUsername(username);
      responseUser = await fUser;
      await fUser.whenComplete(() {
        _defaultHome = HomePage(user: responseUser, sucesso: true, open: true, mensagem: "");
        loginSucedido = true;
      });
    }
  }

  List<HorarioMarcado> horariosMarcados = new List<HorarioMarcado>();
  if(loginSucedido) {
    horariosMarcados = await HorarioMarcadoApi.findHorarioMarcadoByUser(responseUser);
  }

  // Run app!
  runApp(new MaterialApp(
    title: 'App',
    home: _defaultHome,
    routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      '/home': (BuildContext context) => new HomePage(user: responseUser, sucesso: true, open: true, mensagem: "", horariosMarcados: horariosMarcados,),
      '/login': (BuildContext context) =>
          new LoginPage(sucesso: true, open: true)
    },
  ));
}

class HomePage extends StatefulWidget {
  final User user;
  final bool sucesso;
  final bool open;
  final String mensagem;
  final List<HorarioMarcado> horariosMarcados;
  // final List<HorarioMarcado> horariosMarcados;

  const HomePage({this.user, this.sucesso, this.open, this.mensagem, this.horariosMarcados});
  // const HomePage({this.user, this.horariosMarcados});


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return widget.user.cliente != null
        ? _buildHomePageCliente(context, widget.user, widget.horariosMarcados)
        : _buildHomePageBarbearia(context, widget.user, widget.horariosMarcados);
  }
}

Widget _buildHomePageCliente(BuildContext context, User user, List<HorarioMarcado> horariosMarcados) {
  DateFormat dateFormat = new DateFormat("HH:mm");
  DateFormat dateFormatApenasDia = new DateFormat("dd/MM");

  return new Scaffold(
    appBar: new AppBar(
      title: new Text("Olá, " + user.cliente.nome),
      elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
    ),
    drawer: new Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text(user.cliente.nome),
            accountEmail: new Text(user.username),
            currentAccountPicture: new CircleAvatar(
              backgroundColor: Colors.black38,
              child: new Text(user.cliente.nome.substring(0, 1)),
            ),
          ),
          new ListTile(
            title: new Text("Eu"),
            trailing: new Icon(Icons.arrow_back),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new FutureTest()));
            },
          ),
          new ListTile(
            title: new Text("Não"),
            trailing: new Icon(Icons.add_shopping_cart),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new HorarioMarcadoForm()));
            },
          ),
          new ListTile(
            title: new Text("Listagem barberias"),
            trailing: new Icon(Icons.accessibility),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new ListagemBarbearia(loggedUser: user,)));
            },
          ),
          new ListTile(
            title: new Text("Cadastro de cliente"),
            trailing: new Icon(Icons.accessibility),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new CadastroCliente()));
            },
          ),
          new Divider(),
          new ListTile(
            title: new Text("Logout"),
            trailing: new Icon(Icons.close),
            onTap: () {
              authService.logout();
              Navigator.of(context).pushReplacement(new MaterialPageRoute(
                  builder: (BuildContext context) => new LoginPage(
                        sucesso: false,
                        open: true,
                      )));
            },
          ),
        ],
      ),
    ),
    body: new Container(
      child: Wrap(
        children: <Widget>[
        Center(
          child: Text("Horários Marcados"),
        ),
        for(HorarioMarcado horarioMarcado in horariosMarcados) GestureDetector(
          child: Card(
            child: Wrap(
              children: <Widget>[
                Text(
                  "Dia ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(dateFormatApenasDia.format(horarioMarcado.dia) +
                    " as " +
                    dateFormat.format(horarioMarcado.horario.hora)),
              ],
            ),
          ),
        )
        ],
      ),
    ),
  );
}

Widget _buildHomePageBarbearia(BuildContext context, User user, List<HorarioMarcado> horariosMarcados) {
  DateFormat dateFormat = new DateFormat("HH:mm");
  DateFormat dateFormatApenasDia = new DateFormat("dd/MM");
  return new Scaffold(
    appBar: new AppBar(
      title: new Text("Olá, " + user.barbeiro.nome),
      elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
    ),
    drawer: new Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text(user.barbeiro.nome),
            accountEmail: new Text(user.username),
            currentAccountPicture: new CircleAvatar(
              backgroundColor: Colors.black38,
              child: new Text(user.barbeiro.nome.substring(0, 1)),
            ),
          ),
          new ListTile(
            title: new Text("Eu"),
            trailing: new Icon(Icons.arrow_back),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new FutureTest()));
            },
          ),
          new ListTile(
            title: new Text("Minha Barbearia"),
            trailing: new Icon(Icons.add),
            onTap: () async {
              Navigator.of(context).pop();
             Future<List<Barbearia>> fBarbearias = _findCompletoMinhasBarbearias(user);
             List<Barbearia> minhasBarbearias  = new List<Barbearia>();
             await fBarbearias.whenComplete( () async {
             minhasBarbearias = await fBarbearias;
             });
             if(minhasBarbearias.length == 1) {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new MinhaBarbearia(barbearia: minhasBarbearias[0], loggedUser: user, open: true, sucesso: true, mensagem: "",)));
             } else {
               Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new ListagemBarbearia(barbearias: minhasBarbearias, loggedUser: user)));
             }
            },
          ),
          new ListTile(
            title: new Text("Listagem barberias"),
            trailing: new Icon(Icons.accessibility),
            onTap: () async {
              Future<List<Barbearia>> fBarbearias = _listaBarbearias();
              List<Barbearia> barbearias = await fBarbearias;
              await fBarbearias.whenComplete( () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new ListagemBarbearia(loggedUser: user, barbearias: barbearias,)));
              });
            },
          ),
          new ListTile(
            title: new Text("Cadastro de cliente"),
            trailing: new Icon(Icons.accessibility),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new CadastroCliente()));
            },
          ),
          new ListTile(
            title: new Text("Cadastro de barbearia"),
            trailing: new Icon(Icons.accessibility),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new CadastroBarbearia(open: true, sucesso: true, mensagem: "", loggedUser: user)));
            },
          ),
          new Divider(),
          new ListTile(
            title: new Text("Logout"),
            trailing: new Icon(Icons.close),
            onTap: () {
              authService.logout();
              Navigator.of(context).pushReplacement(new MaterialPageRoute(
                  builder: (BuildContext context) => new LoginPage(
                        sucesso: false,
                        open: true,
                      )));
            },
          ),
        ],
      ),
    ),
    body: new Container(
      child: Wrap(
        children: <Widget>[
        Center(
          child: Text("Horários Marcados"),
        ),
        for(HorarioMarcado horarioMarcado in horariosMarcados) GestureDetector(
          child: Card(
            child: Wrap(
              children: <Widget>[
                Text(
                  "Dia ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(dateFormatApenasDia.format(horarioMarcado.dia) +
                    " as " +
                    dateFormat.format(horarioMarcado.horario.hora)),
              ],
            ),
          ),
        )
        ],
      ),
    ),
  );
}

Future<List<Barbearia>> _listaBarbearias() async {

  Future<List<Barbearia>> fBarbearias = BarbeariaApi.findAll();
  List<Barbearia> barbearias = await fBarbearias;

  return barbearias;
}

Future<List<Barbearia>> _findCompletoMinhasBarbearias(User user) async {

  Future<List<Barbearia>> fBarbearia = BarbeariaApi.findCompletoMinhasBarbearias(user);
  List<Barbearia> minhasBarbearias = await fBarbearia;
  return minhasBarbearias;
}