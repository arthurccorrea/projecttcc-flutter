// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Horario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Horario _$HorarioFromJson(Map<String, dynamic> json) {
  return Horario()
    ..id = json['id'] as String
    ..descricao = json['descricao'] as String
    ..hora =
        json['hora'] == null ? null : DateTime.parse(json['hora'] as String)
    ..cadastro = json['cadastro'] == null
        ? null
        : DateTime.parse(json['cadastro'] as String)
    ..alterado = json['alterado'] == null
        ? null
        : DateTime.parse(json['alterado'] as String);
}

Map<String, dynamic> _$HorarioToJson(Horario instance) => <String, dynamic>{
      'id': instance.id,
      'descricao': instance.descricao,
      'hora': instance.hora?.toIso8601String(),
      'cadastro': instance.cadastro?.toIso8601String(),
      'alterado': instance.alterado?.toIso8601String()
    };
