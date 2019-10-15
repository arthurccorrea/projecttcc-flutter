// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Barbeiro.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Barbeiro _$BarbeiroFromJson(Map<String, dynamic> json) {
  return Barbeiro()
    ..id = json['id'] as String
    ..barbearia = json['barbearia'] == null
        ? null
        : Barbearia.fromJson(json['barbearia'] as Map<String, dynamic>)
    ..cidade = json['cidade']
    ..nome = json['nome'] as String
    ..cpf = json['cpf'] as String
    ..telefone = json['telefone'] as int
    ..celular = json['celular'] as int
    ..foto = json['foto'] as String
    ..dataNascimento = json['dataNascimento'] == null
        ? null
        : DateTime.parse(json['dataNascimento'] as String)
    ..cadastro = json['cadastro'] == null
        ? null
        : DateTime.parse(json['cadastro'] as String)
    ..alterado = json['alterado'] == null
        ? null
        : DateTime.parse(json['alterado'] as String)
    ..horariosMarcados = (json['horariosMarcados'] as List)
        ?.map((e) => e == null
            ? null
            : HorarioMarcado.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$BarbeiroToJson(Barbeiro instance) => <String, dynamic>{
      'id': instance.id,
      'barbearia': instance.barbearia,
      'cidade': instance.cidade,
      'nome': instance.nome,
      'cpf': instance.cpf,
      'telefone': instance.telefone,
      'celular': instance.celular,
      'foto': instance.foto,
      'dataNascimento': instance.dataNascimento?.toIso8601String(),
      'cadastro': instance.cadastro?.toIso8601String(),
      'alterado': instance.alterado?.toIso8601String(),
      'horariosMarcados': instance.horariosMarcados
    };
