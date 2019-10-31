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
import 'package:appbarbearia_flutter/pages/horarioMarcadoPage.dart';
import 'package:appbarbearia_flutter/pages/listagemBarbearia.dart';
import 'package:appbarbearia_flutter/pages/loginPage.dart';
import 'package:appbarbearia_flutter/pages/minhaBarbearia.dart';
import 'package:appbarbearia_flutter/pages/pagina_teste.dart';
import 'package:appbarbearia_flutter/pages/pesquisasBarbearias.dart';
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
  List<HorarioMarcado> horariosMarcados = new List<HorarioMarcado>();
  if (token != null && token.isNotEmpty) {
    bool response = await appAuth.validarToken(token);
    if (response) {
      String username = await authService.getLoggedUserUsername();
      Future<User> fUser = authService.getUserByUsername(username);
      loginSucedido = true;
      responseUser = await fUser;

      if (loginSucedido) {
        horariosMarcados =
            await HorarioMarcadoApi.findHorarioMarcadoByUser(responseUser);
      }
      await fUser.whenComplete(() {
        _defaultHome = HomePage(
            user: responseUser,
            sucesso: true,
            open: true,
            mensagem: "",
            horariosMarcados: horariosMarcados);
      });
    }
  }

  // Run app!
  runApp(new MaterialApp(
    title: 'App',
    home: _defaultHome,
    routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      '/home': (BuildContext context) => new HomePage(
          user: responseUser,
          sucesso: true,
          open: true,
          mensagem: "",
          horariosMarcados: horariosMarcados),
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

  const HomePage(
      {this.user,
      this.sucesso,
      this.open,
      this.mensagem,
      this.horariosMarcados});
  // const HomePage({this.user, this.horariosMarcados});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return widget.user.cliente != null
        ? _buildHomePageCliente(context, widget.user, widget.horariosMarcados)
        : _buildHomePageBarbearia(
            context, widget.user, widget.horariosMarcados);
  }
}

Widget _buildHomePageCliente(
    BuildContext context, User user, List<HorarioMarcado> horariosMarcados) {
  DateFormat dateFormat = new DateFormat("HH:mm");
  DateFormat dateFormatApenasDia = new DateFormat("dd/MM");

  return new Scaffold(
    appBar: new AppBar(
      title: new Text("Olá, " + user.cliente.nome),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          onPressed: () async {
             List<HorarioMarcado> _horariosMarcados =
                await HorarioMarcadoApi.findHorarioMarcadoByUser(user);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => new HomePage(
                    horariosMarcados: _horariosMarcados,
                    user: user,
                    mensagem: "",
                    open: true,
                    sucesso: true,
                  )));
          },
        )
      ],
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
                  builder: (BuildContext context) => new ListagemBarbearia(
                        loggedUser: user,
                      )));
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
      margin: EdgeInsets.all(7),
      child: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Divider(thickness: 1, color: Colors.black),
              Center(
                child: Text(
                  "Horários Marcados a partir de hoje",
                  style: TextStyle(
                    fontSize: 23,
                  ),
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.black,
              ),
              if (horariosMarcados.length == 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Você ainda não possui horários marcados",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        )),
                  ],
                ),
              for (HorarioMarcado horarioMarcado in horariosMarcados)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new HorarioMarcadoPage(
                                  horarioMarcado: horarioMarcado,
                                  loggedUser: user,
                                )));
                  },
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Wrap(
                          children: <Widget>[
                            Text("Em " +
                                horarioMarcado.barbearia.nome +
                                " com " +
                                horarioMarcado.barbeiro.nome),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 17, 0, 17),
                            ),
                            Text(
                              "Dia ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(dateFormatApenasDia
                                    .format(horarioMarcado.dia) +
                                " as " +
                                dateFormat.format(horarioMarcado.horario.hora)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ButtonTheme(
                child: RaisedButton(
                    textColor: Colors.white,
                    child: Text("Ver a listagem de barbearias"),
                    onPressed: () async {
                      Future<List<Barbearia>> fBarbearias = _listaBarbearias(user);
                      List<Barbearia> barbearias = await fBarbearias;
                        Navigator.of(context).pop();
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new ListagemBarbearia(
                                  loggedUser: user,
                                  barbearias: barbearias,
                                )));
                    }),
              )
            ],
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.search),
      onPressed: () {
        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new PesquisaBarbearias(loggedUser: user,)));
      },
      ),
  );
}

Widget _buildHomePageBarbearia(
    BuildContext context, User user, List<HorarioMarcado> horariosMarcados) {
  DateFormat dateFormat = new DateFormat("HH:mm");
  DateFormat dateFormatApenasDia = new DateFormat("dd/MM");
  return new Scaffold(
    appBar: new AppBar(
      title: new Text("Olá, " + user.barbeiro.nome),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          onPressed: () async {
            List<HorarioMarcado> _horariosMarcados =
                await HorarioMarcadoApi.findHorarioMarcadoByUser(user);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => new HomePage(
                      horariosMarcados: _horariosMarcados,
                      user: user,
                      mensagem: "",
                      open: true,
                      sucesso: true,
                    )));
          },
        )
      ],
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
            title: new Text("Minha Barbearia"),
            trailing: new Icon(Icons.add),
            onTap: () async {
              Navigator.of(context).pop();
              Future<List<Barbearia>> fBarbearias =
                  _findCompletoMinhasBarbearias(user);
              List<Barbearia> minhasBarbearias = new List<Barbearia>();
              await fBarbearias.whenComplete(() async {
                minhasBarbearias = await fBarbearias;
              });
              if (minhasBarbearias.length == 1) {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new MinhaBarbearia(
                          barbearia: minhasBarbearias[0],
                          loggedUser: user,
                          open: true,
                          sucesso: true,
                          mensagem: "",
                        )));
              } else {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new ListagemBarbearia(
                        barbearias: minhasBarbearias, loggedUser: user)));
              }
            },
          ),
          new ListTile(
            title: new Text("Listagem barberias"),
            trailing: new Icon(Icons.accessibility),
            onTap: () async {
              Future<List<Barbearia>> fBarbearias = _listaBarbearias(user);
              List<Barbearia> barbearias = await fBarbearias;
              await fBarbearias.whenComplete(() {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new ListagemBarbearia(
                          loggedUser: user,
                          barbearias: barbearias,
                        )));
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
                  builder: (BuildContext context) => new CadastroBarbearia(
                      open: true,
                      sucesso: true,
                      mensagem: "",
                      loggedUser: user)));
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
      margin: EdgeInsets.all(7.0),
      child: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Divider(thickness: 1, color: Colors.black),
              Center(
                child: Text(
                  "Horários Marcados a partir de hoje",
                  style: TextStyle(
                    fontSize: 23,
                  ),
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.black,
              ),
              if (horariosMarcados.length == 0)
                Text("Você ainda não possui horários marcados"),
              for (HorarioMarcado horarioMarcado in horariosMarcados)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new HorarioMarcadoPage(
                                  horarioMarcado: horarioMarcado,
                                  loggedUser: user,
                                )));
                  },
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            horarioMarcado.cliente != null
                                ? Text(horarioMarcado.cliente.nome)
                                : Text(horarioMarcado.clienteNome),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 17, 0, 17),
                            ),
                            Text(
                              "Dia ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(dateFormatApenasDia
                                    .format(horarioMarcado.dia) +
                                " as " +
                                dateFormat.format(horarioMarcado.horario.hora)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ButtonTheme(
                child: RaisedButton(
                    textColor: Colors.white,
                    child: Text("Ver a listagem de barbearias"),
                    onPressed: () async {
                      Future<List<Barbearia>> fBarbearias = _listaBarbearias(user);
                      List<Barbearia> barbearias = await fBarbearias;
                      await fBarbearias.whenComplete(() {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new ListagemBarbearia(
                                  loggedUser: user,
                                  barbearias: barbearias,
                                )));
                      });
                    }),
              )
            ],
          ),
        ],
      ),
    ),
  );
}

Future<List<Barbearia>> _listaBarbearias(User user) async {
  Future<List<Barbearia>> fBarbearias = BarbeariaApi.findAllByUser(user);
  List<Barbearia> barbearias = await fBarbearias;

  return barbearias;
}

Future<List<Barbearia>> _findCompletoMinhasBarbearias(User user) async {
  Future<List<Barbearia>> fBarbearia =
      BarbeariaApi.findCompletoMinhasBarbearias(user);
  List<Barbearia> minhasBarbearias = await fBarbearia;
  return minhasBarbearias;
}
