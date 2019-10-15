// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Servico.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Servico _$ServicoFromJson(Map<String, dynamic> json) {
  return Servico()
    ..id = json['id'] as String
    ..barbearia = json['barbearia'] == null
        ? null
        : Barbearia.fromJson(json['barbearia'] as Map<String, dynamic>)
    ..descricao = json['descricao'] as String
    ..preco = (json['preco'] as num)?.toDouble()
    ..cadastro = json['cadastro'] == null
        ? null
        : DateTime.parse(json['cadastro'] as String)
    ..alterado = json['alterado'] == null
        ? null
        : DateTime.parse(json['alterado'] as String);
}

Map<String, dynamic> _$ServicoToJson(Servico instance) => <String, dynamic>{
      'id': instance.id,
      'barbearia': instance.barbearia,
      'descricao': instance.descricao,
      'preco': instance.preco,
      'cadastro': instance.cadastro?.toIso8601String(),
      'alterado': instance.alterado?.toIso8601String()
    };
