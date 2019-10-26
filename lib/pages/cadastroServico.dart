import 'package:appbarbearia_flutter/api/ServicoApi.dart';
import 'package:appbarbearia_flutter/model/Barbearia.dart';
import 'package:appbarbearia_flutter/model/Servico.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';


class CadastroServico extends StatefulWidget {

  final Barbearia barbearia;

  const CadastroServico({this.barbearia});

  @override
  _CadastroServicoState createState() => _CadastroServicoState();
}

class _CadastroServicoState extends State<CadastroServico> {

  Servico _servico = new Servico();
  final _formKey = GlobalKey<FormState>();
  var _eDescricao = TextEditingController();
  var _eCusto = MoneyMaskedTextController(decimalSeparator: ".");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro de serviço")),
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
                _servico.descricao = custo;
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
                    if(responseBarbearia.id != null){
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => new PaginaBarbearia(barbearia: responseBarbearia, open: false, sucesso: true, mensagem: "Cadastro Efetuado com sucesso")));
                    } else {
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => new CadastroBarbearia(sucesso: false, open: false, mensagem: "Ops, algo deu errado, por favor, faça seu cadastro novamente",loggedUser: widget.loggedUser,)));
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

_saveServico(Servico servico, Barbearia barbearia) async {
  servico.barbearia = barbearia;
  Future<Servico> fServico = ServicoApi.saveServico(servico); 
  Servico responseServico = await fServico;

 return responseServico;
}