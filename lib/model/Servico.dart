import 'package:json_annotation/json_annotation.dart';

import 'Barbearia.dart';

part 'Servico.g.dart';

@JsonSerializable()
class Servico {
  String id;
	Barbearia barbearia;
	String descricao;
	double preco;
	DateTime cadastro;
	DateTime alterado;

  Servico();

  factory Servico.fromJson(Map<String, dynamic> json) => _$ServicoFromJson(json);

  Map<String, dynamic> toJson() => _$ServicoToJson(this);
}

  