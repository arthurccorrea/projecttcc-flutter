// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Barbearia.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Barbearia _$BarbeariaFromJson(Map<String, dynamic> json) {
  return Barbearia()
    ..id = json['id'] as String
    ..nome = json['nome'] as String
    ..descricao = json['descricao'] as String
    ..cidade = json['cidade'] as String
    ..endereco = json['endereco'] as String
    ..estado = _$enumDecodeNullable(_$EstadosEnumMap, json['estado'])
    ..horaAbertura = json['horaAbertura'] as int
    ..minutoAbertura = json['minutoAbertura'] as int
    ..horaFechamento = json['horaFechamento'] as int
    ..minutoFechamento = json['minutoFechamento'] as int
    ..horarioAbertura = json['horarioAbertura'] == null
        ? null
        : DateTime.parse(json['horarioAbertura'] as String)
    ..horarioFechamento = json['horarioFechamento'] == null
        ? null
        : DateTime.parse(json['horarioFechamento'] as String)
    ..cadastro = json['cadastro'] == null
        ? null
        : DateTime.parse(json['cadastro'] as String)
    ..alterado = json['alterado'] == null
        ? null
        : DateTime.parse(json['alterado'] as String)
    ..servicos = (json['servicos'] as List)
        ?.map((e) =>
            e == null ? null : Servico.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..barbeiros = (json['barbeiros'] as List)
        ?.map((e) =>
            e == null ? null : Barbeiro.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..promocoes = (json['promocoes'] as List)
        ?.map((e) =>
            e == null ? null : Promocao.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$BarbeariaToJson(Barbearia instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'descricao': instance.descricao,
      'cidade': instance.cidade,
      'endereco': instance.endereco,
      'estado': _$EstadosEnumMap[instance.estado],
      'horaAbertura': instance.horaAbertura,
      'minutoAbertura': instance.minutoAbertura,
      'horaFechamento': instance.horaFechamento,
      'minutoFechamento': instance.minutoFechamento,
      'horarioAbertura': instance.horarioAbertura?.toIso8601String(),
      'horarioFechamento': instance.horarioFechamento?.toIso8601String(),
      'cadastro': instance.cadastro?.toIso8601String(),
      'alterado': instance.alterado?.toIso8601String(),
      'servicos': instance.servicos,
      'barbeiros': instance.barbeiros,
      'promocoes': instance.promocoes
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
