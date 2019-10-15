import 'package:appbarbearia_flutter/model/Cliente.dart';
import 'package:appbarbearia_flutter/model/User.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UserClienteWrapper.g.dart';

@JsonSerializable()
class UserClienteWrapper {
  User user;
  Cliente cliente;

  UserClienteWrapper();

  factory UserClienteWrapper.fromJson(Map<String, dynamic> json) => _$UserClienteWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$UserClienteWrapperToJson(this);

}