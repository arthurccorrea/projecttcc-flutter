// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserClienteWrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserClienteWrapper _$UserClienteWrapperFromJson(Map<String, dynamic> json) {
  return UserClienteWrapper()
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>)
    ..cliente = json['cliente'] == null
        ? null
        : Cliente.fromJson(json['cliente'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserClienteWrapperToJson(UserClienteWrapper instance) =>
    <String, dynamic>{'user': instance.user, 'cliente': instance.cliente};
