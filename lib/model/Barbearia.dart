import 'package:appbarbearia_flutter/model/Estados.dart';
import 'package:json_annotation/json_annotation.dart';

import 'Barbeiro.dart';
import 'Promocao.dart';
import 'Servico.dart';

part 'Barbearia.g.dart';

@JsonSerializable()
class Barbearia {
  String id;
  String nome;
  String descricao;
  String cidade;
  String endereco;
  Estados estado;
  int horaAbertura;
  int minutoAbertura;
  int horaFechamento;
  int minutoFechamento;
  String foto;
  DateTime horarioAbertura;
  DateTime horarioFechamento;
  DateTime cadastro;
  DateTime alterado;
  List<Servico> servicos;
  List<Barbeiro> barbeiros;
  List<Promocao> promocoes;

  Barbearia();

  Barbearia.construct(String id, String nome, String descricao,String cidade, String endereco, Estados estado, int horaAbertura, int minutoAbertura, int horaFechamento, int minutoFechamento){
    this.id = id;
    this. nome = nome;
    this.descricao = descricao;
    this.cidade = cidade;
    this.endereco = endereco;
    this.estado = estado;
    this.horaAbertura = horaAbertura;
    this.minutoAbertura = minutoAbertura;
    this.horaFechamento = horaFechamento;
    this.minutoAbertura = minutoAbertura;
  }

  factory Barbearia.fromJson(Map<String, dynamic> json) => _$BarbeariaFromJson(json);

  Map<String, dynamic> toJson() => _$BarbeariaToJson(this);

}
