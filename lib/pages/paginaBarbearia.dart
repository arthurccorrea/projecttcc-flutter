import 'package:appbarbearia_flutter/model/Barbearia.dart';
import 'package:appbarbearia_flutter/model/Horario.dart';
import 'package:appbarbearia_flutter/model/Servico.dart';
import 'package:appbarbearia_flutter/model/User.dart';
import 'package:appbarbearia_flutter/pages/horariosBarbearia.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaginaBarbearia extends StatefulWidget {
  final Barbearia barbearia;
  final bool sucesso;
  final bool open;
  final String mensagem;
  final User loggedUser;

  const PaginaBarbearia(
      {this.barbearia, this.sucesso, this.open, this.mensagem, this.loggedUser});

  @override
  _PaginaBarbeariaState createState() => _PaginaBarbeariaState();
}

class _PaginaBarbeariaState extends State<PaginaBarbearia> {
  int tabAtual = 0;
  _DescricaoBarbearia descricaoBarbearia;
  _MeusServicos meusServicos;
  List<Widget> paginas;
  Widget paginaAtual;

  @override
  void initState() {
    descricaoBarbearia = new _DescricaoBarbearia(
      barbearia: widget.barbearia,
      loggedUser: widget.loggedUser,
      open: widget.open,
      sucesso: widget.sucesso,
      mensagem: widget.mensagem,
    );
    meusServicos = new _MeusServicos(
      barbearia: widget.barbearia,
    );

    paginas = [descricaoBarbearia, meusServicos];
    paginaAtual = descricaoBarbearia;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(widget.barbearia.nome),
      ),
      body: paginaAtual,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabAtual,
        onTap: (int index) {
          setState(() => tabAtual = index);
          tabAtual = index;
          paginaAtual = paginas[index];
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(widget.barbearia.nome),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subtitles),
            title: Text("Servicos"),
          ),
        ],
      ),
    );
  }
}

class _MeusServicos extends StatefulWidget {
  final Barbearia barbearia;

  const _MeusServicos({this.barbearia});

  @override
  _MeusServicosState createState() => _MeusServicosState();
}

class _MeusServicosState extends State<_MeusServicos> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemCount: widget.barbearia.servicos.length,
      itemBuilder: (context, i) {
        return GestureDetector(
          child: new Card(
            child: Column(
              children: <Widget>[
                Text(widget.barbearia.servicos[i].descricao,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(
                  "Preço = R\$" + widget.barbearia.servicos[i].preco.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
              ],
            ),
          ),
          onTap: () {},
        );
      },
    ));
  }
}

class _DescricaoBarbearia extends StatefulWidget {
  final Barbearia barbearia;
  final bool open;
  final bool sucesso;
  final User loggedUser;
  final String mensagem;
  final List<Servico> servicos;

  const _DescricaoBarbearia(
      {this.barbearia,
      this.loggedUser,
      this.open,
      this.sucesso,
      this.mensagem, 
      this.servicos});

  @override
  _DescricaoBarbeariaState createState() => _DescricaoBarbeariaState();
}

class _DescricaoBarbeariaState extends State<_DescricaoBarbearia> {
  DateFormat dateFormat = DateFormat("HH:mm");
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      //  MainAxisSize.min,
      children: <Widget>[
        Text(""),
        Text(
          widget.barbearia.nome,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          textAlign: TextAlign.center,
        ),
        Text(""),
        Text(
          " " + widget.barbearia.descricao,
          style: TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        ),
        Text(""),
        Wrap(
          children: <Widget>[
            Text(
              "Local :",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              " " + widget.barbearia.endereco + ", " + widget.barbearia.cidade,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        Text(""),
        Wrap(
          children: <Widget>[
            Text(
              "Horário de abertura :",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              " " +
                  dateFormat.format(
                    widget.barbearia.horarioAbertura,
                  ),
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        Text(""),
        Wrap(
          children: <Widget>[
            Text(
              "Horário de fechamento :",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(" " + dateFormat.format(widget.barbearia.horarioFechamento),
                style: TextStyle(fontSize: 20)),
          ],
        ),
        Text(""),
         widget.barbearia.servicos.length > 0 ? ButtonTheme(
          minWidth: double.infinity,
          child: RaisedButton(
            child: Text("Marcar horário"),
            elevation: 5.0,
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => new HorariosBarbearia(
                            barbearia: widget.barbearia,
                            loggedUser: widget.loggedUser,
                            horariosBarbearia: new List<Horario>(),
                            data: null,
                            minhaBarbearia: false,
                          )));
            },
          ),
        ) : Text("Esta barbearia ainda não possui servicos disponiveis!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.redAccent),),
        !widget.open && widget.sucesso
            ? Text(widget.mensagem,
                style: TextStyle(
                    color: Colors.white, backgroundColor: Colors.green))
            : Text(
                widget.mensagem,
                style:
                    TextStyle(color: Colors.white, backgroundColor: Colors.red),
              ),
      ],
    ));
  }
}
