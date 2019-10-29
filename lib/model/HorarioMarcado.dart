import 'package:appbarbearia_flutter/model/Servico.dart';
import 'package:json_annotation/json_annotation.dart';

import 'Horario.dart';
import 'Barbeiro.dart';
import 'Cliente.dart';

part 'HorarioMarcado.g.dart';

@JsonSerializable()
class HorarioMarcado {

	String id;
	Horario horario;
	Barbeiro barbeiro;
	Cliente cliente;
  Servico servico;
  String clienteNome;
	DateTime dia;
	DateTime cadastro;
	DateTime alterado;

  HorarioMarcado();

  factory HorarioMarcado.fromJson(Map<String, dynamic> json) => _$HorarioMarcadoFromJson(json);

  Map<String, dynamic> toJson() => _$HorarioMarcadoToJson(this);
}