// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HorarioMarcado.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HorarioMarcado _$HorarioMarcadoFromJson(Map<String, dynamic> json) {
  return HorarioMarcado()
    ..id = json['id'] as String
    ..horario = json['horario'] == null
        ? null
        : Horario.fromJson(json['horario'] as Map<String, dynamic>)
    ..barbeiro = json['barbeiro'] == null
        ? null
        : Barbeiro.fromJson(json['barbeiro'] as Map<String, dynamic>)
    ..cliente = json['cliente'] == null
        ? null
        : Cliente.fromJson(json['cliente'] as Map<String, dynamic>)
    ..servico = json['servico'] == null
        ? null
        : Servico.fromJson(json['servico'] as Map<String, dynamic>)
    ..clienteNome = json['clienteNome'] as String
    ..dia = json['dia'] == null ? null : DateTime.parse(json['dia'] as String)
    ..cadastro = json['cadastro'] == null
        ? null
        : DateTime.parse(json['cadastro'] as String)
    ..alterado = json['alterado'] == null
        ? null
        : DateTime.parse(json['alterado'] as String);
}

Map<String, dynamic> _$HorarioMarcadoToJson(HorarioMarcado instance) =>
    <String, dynamic>{
      'id': instance.id,
      'horario': instance.horario,
      'barbeiro': instance.barbeiro,
      'cliente': instance.cliente,
      'servico': instance.servico,
      'clienteNome': instance.clienteNome,
      'dia': instance.dia?.toIso8601String(),
      'cadastro': instance.cadastro?.toIso8601String(),
      'alterado': instance.alterado?.toIso8601String()
    };
