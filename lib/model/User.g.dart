// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..id = json['id'] as String
    ..username = json['username'] as String
    ..password = json['password'] as String
    ..cliente = json['cliente'] == null
        ? null
        : Cliente.fromJson(json['cliente'] as Map<String, dynamic>)
    ..barbeiro = json['barbeiro'] == null
        ? null
        : Barbeiro.fromJson(json['barbeiro'] as Map<String, dynamic>)
    ..roles = (json['roles'] as List)
        ?.map(
            (e) => e == null ? null : Role.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..erros = json['erros'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'password': instance.password,
      'cliente': instance.cliente,
      'barbeiro': instance.barbeiro,
      'roles': instance.roles,
      'erros': instance.erros
    };
