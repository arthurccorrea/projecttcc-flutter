import 'package:appbarbearia_flutter/api/AuthApiService.dart';
import 'package:appbarbearia_flutter/main.dart';
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

  TextEditingController eEmail = new TextEditingController();
  TextEditingController ePassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {



    return new Scaffold(
    appBar: new AppBar(
      title: new Text('Login'),
    ),
    body: new ListView(
      children: <Widget>[
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          controller: eEmail,
          onEditingComplete: () {
            _user.username = eEmail.text;
          },
        ),
        TextFormField(
          autocorrect: false,
          obscureText: true,
          controller: ePassword,
          onEditingComplete: () {
            print(ePassword.text);
            _user.password = ePassword.text;
            print(_user.password);
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
      )
      ],
    ),
  );
  }

  void validateLogin(User user) async{
//    print(user.username);
    bool response = await authService.obterToken(user);
    if(response){
      Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    } else {
       Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
    }
  }

}