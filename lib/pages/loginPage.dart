import 'package:appbarbearia_flutter/api/AuthApiService.dart';
import 'package:appbarbearia_flutter/main.dart';
import 'package:appbarbearia_flutter/pages/cadastroCliente.dart';
import 'package:flutter/material.dart';
import 'package:appbarbearia_flutter/model/User.dart';
import 'package:flutter/services.dart';

AuthApiService authService = new AuthApiService();



class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  User _user = new User();

  TextEditingController eUsername = new TextEditingController();
  TextEditingController ePassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
    appBar: new AppBar(
      title: new Text('Login'),
    ),
    body: new ListView(
      padding: EdgeInsets.all(15.0),
      children: <Widget>[
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
              ),
            ),
          )
        ],
      ),
        Divider(),
        Row(
          children: <Widget>[
            Center(
              child: Text("Ainda não tem um cadastro?", textAlign: TextAlign.center,),
            ),
            ]
          ),
          Row(
            children: <Widget> [
              Expanded(
              child: ButtonTheme(
                child:
                RaisedButton(
                  child: Text("Fazer cadastro como cliente"),
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (BuildContext context) => CadastroCliente()));
                  },
                ),
              ),
            ),
            ]
          ),
          Row(
            children: <Widget> [
              Expanded(
              child: ButtonTheme(
                child:
                RaisedButton(
                  child: Text("Fazer cadastro como barbeiro"),
//                  onPressed: () {
//                    Navigator.push(
//                        context, MaterialPageRoute(builder: (BuildContext context) => CadastroBarbeiro()));
//                  },
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

  void validateLogin(User user) async{
//    print(user.username);
      Future<bool>fBool = authService.obterToken(user);
      bool response = await fBool;
      fBool.whenComplete(() {
        if(response){
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (BuildContext context) => HomePage()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
        }
    });

  }

}