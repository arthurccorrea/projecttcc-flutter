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
    ..cidade = json['cidade'] as String
    ..endereco = json['endereco'] as String
    ..estado = _$enumDecodeNullable(_$EstadosEnumMap, json['estado'])
    ..nome = json['nome'] as String
    ..cpf = json['cpf'] as String
    ..telefone = json['telefone'] as String
    ..celular = json['celular'] as String
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
        ?.toList()
    ..erros = json['erros'] as String;
}

Map<String, dynamic> _$BarbeiroToJson(Barbeiro instance) => <String, dynamic>{
      'id': instance.id,
      'barbearia': instance.barbearia,
      'cidade': instance.cidade,
      'endereco': instance.endereco,
      'estado': _$EstadosEnumMap[instance.estado],
      'nome': instance.nome,
      'cpf': instance.cpf,
      'telefone': instance.telefone,
      'celular': instance.celular,
      'foto': instance.foto,
      'dataNascimento': instance.dataNascimento?.toIso8601String(),
      'cadastro': instance.cadastro?.toIso8601String(),
      'alterado': instance.alterado?.toIso8601String(),
      'horariosMarcados': instance.horariosMarcados,
      'erros': instance.erros
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$EstadosEnumMap = <Estados, dynamic>{
  Estados.AC: 'AC',
  Estados.AL: 'AL',
  Estados.AP: 'AP',
  Estados.AM: 'AM',
  Estados.BA: 'BA',
  Estados.CE: 'CE',
  Estados.DF: 'DF',
  Estados.ES: 'ES',
  Estados.GO: 'GO',
  Estados.MA: 'MA',
  Estados.MT: 'MT',
  Estados.MS: 'MS',
  Estados.PA: 'PA',
  Estados.PB: 'PB',
  Estados.RE: 'RE',
  Estados.PE: 'PE',
  Estados.PI: 'PI',
  Estados.RJ: 'RJ',
  Estados.RN: 'RN',
  Estados.RS: 'RS',
  Estados.RO: 'RO',
  Estados.RR: 'RR',
  Estados.SC: 'SC',
  Estados.SP: 'SP',
  Estados.SE: 'SE',
  Estados.TO: 'TO'
};
