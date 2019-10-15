import 'package:json_annotation/json_annotation.dart';

import 'HorarioMarcado.dart';
import 'Barbearia.dart';

part 'Barbeiro.g.dart';

@JsonSerializable()
class Barbeiro {
	 String id;
	 Barbearia barbearia;
	 String cidade;
   String endereco;
	 String nome;
	 String cpf;
	 int telefone;
	 int celular;
	// URL
	 String foto;
	 DateTime dataNascimento;
	 DateTime cadastro;
	 DateTime alterado;
	 List<HorarioMarcado> horariosMarcados;

  Barbeiro();

  factory Barbeiro.fromJson(Map<String, dynamic> json) => _$BarbeiroFromJson(json);

  Map<String, dynamic> toJson() => _$BarbeiroToJson(this);
}