import 'package:appbarbearia_flutter/api/AuthApiService.dart';
import 'package:appbarbearia_flutter/api/HorarioMarcadoApi.dart';
import 'package:appbarbearia_flutter/main.dart';
import 'package:appbarbearia_flutter/model/HorarioMarcado.dart';
import 'package:appbarbearia_flutter/model/User.dart';
import 'package:appbarbearia_flutter/pages/cadastroBarbeiro.dart';
import 'package:appbarbearia_flutter/pages/cadastroCliente.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AuthApiService authService = new AuthApiService();



class LoginPage extends StatefulWidget {
  final bool sucesso;
  final bool open;
  const LoginPage({this.sucesso, this.open });

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<ScaffoldState> loginScaffold = new GlobalKey<ScaffoldState>();
  User _user = new User();

  TextEditingController eUsername = new TextEditingController();
  TextEditingController ePassword = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    var sucesso = widget.sucesso;
    var open = widget.open;
    return new Scaffold(
      key: loginScaffold,
      appBar: new AppBar(
        title: new Text('Login'),
      ),
      body: new ListView(
        padding: EdgeInsets.all(15.0),
        children: <Widget>[
          Image.network('https://i.ibb.co/xGYC5VG/kisspng-comb-barber-hairstyle-hairdresser-vector-barber-tools-5a951d19d21015-1148711815197217538604.png', height: 120.0 ,width: 80.0 ,),
          Text("App Barbearia", style: TextStyle(fontSize: 30.0), textAlign: TextAlign.center,), 
          Padding (padding: EdgeInsets.fromLTRB(0, 60, 0, 0)),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: "Digite seu email",
            ),
            controller: eUsername,
            onChanged: (username) {
              _user.username = username;
            },
          ),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "Digite sua senha",
            ),
            controller: ePassword,
            onChanged: (password) {
              _user.password = password;
            },
          ),

          Row(
            children: <Widget>[
              Expanded(
                child: ButtonTheme(
                  child:
                  RaisedButton(
                    child: Text("Log in"),
                    onPressed: () {
                      validateLogin(_user);
                    },
                    textColor: Colors.white,
                  ),
                ),
              )
            ],
          ),
          Padding (padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
          Row(
             children: <Widget>[
                 Expanded(
                     child: Divider()
                    ),
                            Text("OU"),   
                 Expanded(
              child: Divider()
              ),
            ]
          ),
          Padding (padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
          Row(
              children: <Widget>[
                Center(
                  child: Text(
                    "Ainda não tem um cadastro?", textAlign: TextAlign.center,),
                ),
              ]
          ),
          Row(
              children: <Widget>[
                Expanded(
                  child: ButtonTheme(
                    child:
                    RaisedButton(
                      child: Text("Fazer cadastro como cliente"),
                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(
                            builder: (BuildContext context) =>
                                CadastroCliente()));
                      },
                      textColor: Colors.white,
                    ),
                  ),
                ),
              ]
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: ButtonTheme(
                  child:
                  RaisedButton(
                    child: Text("Fazer cadastro como barbeiro"),
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CadastroBarbeiro()));
                    },
                    textColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: sucesso && !open ? Text("Cadastro efetuado com sucesso",
                  style: TextStyle(backgroundColor: Colors.green,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),) : Text(""),
              )
            ],
          )
        ],
      ),
    );
  }

  void validateLogin(User user) async {
//    print(user.username);
    Future<bool>fBool = authService.gerarToken(user);
    bool response = await fBool;
    await fBool.whenComplete(() async {
      if (response) {
        Future<User> fUser = authService.getUserByUsername(user .username);
        User responseUser = await fUser;
        fUser.whenComplete(() async {
          List<HorarioMarcado> horariosMarcados = await HorarioMarcadoApi.findHorarioMarcadoByUser(responseUser);
          Navigator.pushReplacement(
              context, MaterialPageRoute(
              builder: (BuildContext context) => HomePage(user: responseUser, sucesso: true, open: true, mensagem: "", horariosMarcados: horariosMarcados,)));
        });
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (BuildContext context) =>
            LoginPage(open: true, sucesso: false)));
      }
    });
  }
}