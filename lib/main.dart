import 'dart:io';

import 'package:appbarbearia_flutter/api/AuthApiService.dart';
import 'package:appbarbearia_flutter/model/HorarioMarcado.dart';
import 'package:appbarbearia_flutter/model/User.dart';
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
  Widget _defaultHome = new LoginPage(sucesso: true, open: true);
  File tokenFile = await appAuth.localFile;
  token = tokenFile.readAsStringSync();
  User responseUser = new User();
  if (token != null && token.isNotEmpty) {
    bool response = await appAuth.validarToken(token);
    if (response) {
      String username = await authService.getLoggedUserUsername();
      Future<User> fUser = authService.getUserByUsername(username);
      responseUser = await fUser;
      fUser.whenComplete(() {
        _defaultHome = HomePage(user: responseUser, sucesso: true, open: true, mensagem: "");
      });
    }
  }

  // Run app!
  runApp(new MaterialApp(
    title: 'App',
    home: _defaultHome,
    routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      '/home': (BuildContext context) => new HomePage(user: responseUser, sucesso: true, open: true, mensagem: ""),
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
  // final List<HorarioMarcado> horariosMarcados;

  const HomePage({this.user, this.sucesso, this.open, this.mensagem});
  // const HomePage({this.user, this.horariosMarcados});


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return widget.user.cliente != null
        ? _buildHomePageCliente(context, widget.user)
        : _buildHomePageBarbearia(context, widget.user);
  }
}

Widget _buildHomePageCliente(BuildContext context, User user) {
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
                  builder: (BuildContext context) => new ListagemBarbearia()));
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
      child: new Center(
        child: ListView(
          children: <Widget>[
            Card(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Text(
                          "Horarios Marcados",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                    Divider(),
                    // ListView.builder(
                    //   itemCount: horariosMarcados.length,
                    //   itemBuilder: (context, i) {
                    //     return new GestureDetector(
                    //       Card(
                    //         child: Column(
                    //           children: <Widget>[
                    //             Text("Horario: $horariosMarcados[i].horario"),                            
                    //           ],
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildHomePageBarbearia(BuildContext context, User user) {
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
                  builder: (BuildContext context) => new ListagemBarbearia()));
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
      child: new Center(
        child: ListView(
          children: <Widget>[Text("HOME PAGE")],
        ),
      ),
    ),
  );
}
