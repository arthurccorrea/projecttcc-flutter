import 'package:appbarbearia_flutter/api/BarbeariaApi.dart';
import 'package:appbarbearia_flutter/api/ServicoApi.dart';
import 'package:appbarbearia_flutter/model/Barbearia.dart';
import 'package:appbarbearia_flutter/model/Barbeiro.dart';
import 'package:appbarbearia_flutter/model/Horario.dart';
import 'package:appbarbearia_flutter/model/Servico.dart';
import 'package:appbarbearia_flutter/model/User.dart';
import 'package:appbarbearia_flutter/pages/horariosBarbearia.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MinhaBarbearia extends StatefulWidget {
  final Barbearia barbearia;
  final Barbeiro barbeiro;
  final User loggedUser;
  final bool open;
  final bool sucesso;
  final String mensagem;

  const MinhaBarbearia({this.barbearia, this.loggedUser, this.open, this.sucesso, this.mensagem, this.barbeiro});

  @override
  _MinhaBarbeariaState createState() => _MinhaBarbeariaState();
}

class _MinhaBarbeariaState extends State<MinhaBarbearia> {
  int tabAtual = 0;
  _DescricaoBarbearia descricaoBarbearia;
  _MeusServicos meusServicos;
  _CadastroServico cadastroServico;
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
    cadastroServico = new _CadastroServico(barbearia: widget.barbearia, loggedUser: widget.loggedUser);

    paginas = [descricaoBarbearia, meusServicos, cadastroServico];
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
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            title: Text("Novo servico"),
          )
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
                Text("Preço = R\$" +widget.barbearia.servicos[i].preco.toString(), style: TextStyle(fontSize: 20),),
                Padding (padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
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

  const _DescricaoBarbearia({this.barbearia, this.loggedUser, this.open, this.sucesso, this.mensagem});

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
        Text(widget.barbearia.nome, style: TextStyle(fontWeight: FontWeight.bold, fontSize:40), textAlign: TextAlign.center,),
        Text(""),
        Text(" " + widget.barbearia.descricao,style: TextStyle(fontSize: 25), textAlign: TextAlign.center, ),       
        Text(""),
        Row(
          children: <Widget>[
            Text("Local :", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            Text(" " + widget.barbearia.endereco + ", " + widget.barbearia.cidade, style: TextStyle(fontSize: 20),),
          ],
        ),
        Text(""),
        Row(
          children: <Widget>[
            Text("Horário de abertura :", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            Text(" " + dateFormat.format( widget.barbearia.horarioAbertura,), style: TextStyle(fontSize: 20),),
        ],
        ),
        Text(""),
        Row(
          children: <Widget>[
            Text("Horário de fechamento :", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            Text(" " + dateFormat.format( widget.barbearia.horarioFechamento), style: TextStyle(fontSize: 20)),
          ],
        ),
        Text(""),
        RaisedButton(
          child: Text("Marcar horário"),
          elevation: 5.0,
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => new HorariosBarbearia(barbearia: widget.barbearia, loggedUser: widget.loggedUser, horariosBarbearia: new List<Horario>(), data: null,)));
          },          
        ),
        !widget.open && widget.sucesso ? Text(widget.mensagem, style: TextStyle(color: Colors.white, backgroundColor: Colors.green)) : Text(widget.mensagem, style: TextStyle(color: Colors.white, backgroundColor: Colors.red),),
      ],
    ));
  }
}

class _CadastroServico extends StatefulWidget {
  final Barbearia barbearia;
  final User loggedUser;

  const _CadastroServico({this.barbearia, this.loggedUser});

  @override
  _CadastroServicoState createState() => _CadastroServicoState();
}

class _CadastroServicoState extends State<_CadastroServico> {
  Servico _servico = new Servico();
  final _formKey = GlobalKey<FormState>();
  var _eDescricao = TextEditingController();
  var _eCusto = TextEditingController();
  // var _eCusto = MoneyMaskedTextController(decimalSeparator: ".", leftSymbol: "R0\$");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
        child: ListView(
          children: <Widget>[
            TextFormField(
              autocorrect: false,
              validator: (value) {
                if(value.isEmpty){
                  return 'Este campo é obrigatório';
                }
                return null;
              },
              decoration: const InputDecoration(
                icon: Icon(Icons.mail),
                hasFloatingPlaceholder: true,
                hintText: "Descrição (*)",
              ),
              controller: _eDescricao,
              onChanged: (descricao) {
                _servico.descricao = descricao;
              },
            ),
            TextFormField(
              autocorrect: false,
              validator: (value) {
                if(value.isEmpty){
                  return 'Este campo é obrigatório';
                }
                return null;
              },
              inputFormatters: <TextInputFormatter> [
                BlacklistingTextInputFormatter(new RegExp('[\\-|\\ ]'))
              ],
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                icon: Icon(Icons.mail),
                hasFloatingPlaceholder: true,
                hintText: "Valor (*)",
              ),
              controller: _eCusto,
              onChanged: (custo) {
                custo.replaceAll(".", ",");
                _servico.preco = double.parse(custo);
              },
            ),
            Row(
              children: <Widget>[
                Expanded(
              child: ButtonTheme(
                minWidth: double.infinity,
                child: RaisedButton(
                  child: Text("Cadastrar"), 
                  key: Key("_submitButton"),
                  onPressed: () async {  
                    Barbearia responseBarbearia =  await _saveServico(_servico, widget.barbearia);
                    if(responseBarbearia.servicos.length == (widget.barbearia.servicos.length + 1)){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => new MinhaBarbearia(barbearia: responseBarbearia, loggedUser: widget.loggedUser, sucesso: true, open: false, mensagem: "Serviço efetuado com sucesso!",)));
                    } else {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => new MinhaBarbearia(barbearia: widget.barbearia, loggedUser: widget.loggedUser, sucesso: false, open: false, mensagem: "Algo deu errado no cadastro de serviço!")));
                    }
                  },
                  elevation: 3.0,
                  color: Colors.purple,
                  textColor: Colors.white,
                  ),
                ),
            ),
          ],
        ),
          ],
      ),
    )
    )
    );
  }
}

Future<Barbearia> _saveServico(Servico servico, Barbearia barbearia) async {
  servico.barbearia = barbearia;
  Future<Servico> fServico = ServicoApi.saveServico(servico); 
  Servico responseServico = await fServico;
  if(responseServico.id == null) {
    return new Barbearia();
  }
  Future<Barbearia> fBarbearia = BarbeariaApi.findCompleteBarbeariaPorBarbeariaId(barbearia.id);
  Barbearia responseBarbearia = await fBarbearia;

  return responseBarbearia;
//  return responseServico;
}