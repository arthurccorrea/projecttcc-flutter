import 'package:json_annotation/json_annotation.dart';

part 'Horario.g.dart';

@JsonSerializable()
class Horario {
   String id;
	 String descricao;
	 DateTime hora;
	 DateTime cadastro;
	 DateTime alterado;

   Horario();

  factory Horario.fromJson(Map<String, dynamic> json) => _$HorarioFromJson(json);

  Map<String, dynamic> toJson() => _$HorarioToJson(this);
}