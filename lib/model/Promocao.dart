import 'package:json_annotation/json_annotation.dart';

import 'Barbearia.dart';
import 'Servico.dart';

part 'Promocao.g.dart';

@JsonSerializable()
class Promocao {
  String id;
	Servico servico;
	Barbearia barbearia;
	String descricao;
	double valorDesconto;
	int porcentagemDesconto;
	DateTime dataInicio;
	DateTime dataTermino;
	DateTime cadastro;
	DateTime alterado;

  Promocao();

  factory Promocao.fromJson(Map<String, dynamic> json) => _$PromocaoFromJson(json);

  Map<String, dynamic> toJson() => _$PromocaoToJson(this);

}