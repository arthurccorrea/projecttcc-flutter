// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Promocao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Promocao _$PromocaoFromJson(Map<String, dynamic> json) {
  return Promocao()
    ..id = json['id'] as String
    ..servico = json['servico'] == null
        ? null
        : Servico.fromJson(json['servico'] as Map<String, dynamic>)
    ..barbearia = json['barbearia'] == null
        ? null
        : Barbearia.fromJson(json['barbearia'] as Map<String, dynamic>)
    ..descricao = json['descricao'] as String
    ..valorDesconto = (json['valorDesconto'] as num)?.toDouble()
    ..porcentagemDesconto = json['porcentagemDesconto'] as int
    ..dataInicio = json['dataInicio'] == null
        ? null
        : DateTime.parse(json['dataInicio'] as String)
    ..dataTermino = json['dataTermino'] == null
        ? null
        : DateTime.parse(json['dataTermino'] as String)
    ..cadastro = json['cadastro'] == null
        ? null
        : DateTime.parse(json['cadastro'] as String)
    ..alterado = json['alterado'] == null
        ? null
        : DateTime.parse(json['alterado'] as String);
}

Map<String, dynamic> _$PromocaoToJson(Promocao instance) => <String, dynamic>{
      'id': instance.id,
      'servico': instance.servico,
      'barbearia': instance.barbearia,
      'descricao': instance.descricao,
      'valorDesconto': instance.valorDesconto,
      'porcentagemDesconto': instance.porcentagemDesconto,
      'dataInicio': instance.dataInicio?.toIso8601String(),
      'dataTermino': instance.dataTermino?.toIso8601String(),
      'cadastro': instance.cadastro?.toIso8601String(),
      'alterado': instance.alterado?.toIso8601String()
    };
