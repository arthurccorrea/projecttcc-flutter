// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserBarbeiroWrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBarbeiroWrapper _$UserBarbeiroWrapperFromJson(Map<String, dynamic> json) {
  return UserBarbeiroWrapper()
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>)
    ..barbeiro = json['barbeiro'] == null
        ? null
        : Barbeiro.fromJson(json['barbeiro'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserBarbeiroWrapperToJson(
        UserBarbeiroWrapper instance) =>
    <String, dynamic>{'user': instance.user, 'barbeiro': instance.barbeiro};
