import 'package:appbarbearia_flutter/model/Barbeiro.dart';
import 'package:appbarbearia_flutter/model/User.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UserBarbeiroWrapper.g.dart';

@JsonSerializable()
class UserBarbeiroWrapper {
  User user;
  Barbeiro barbeiro;

  UserBarbeiroWrapper();

  factory UserBarbeiroWrapper.fromJson(Map<String, dynamic> json) => _$UserBarbeiroWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$UserBarbeiroWrapperToJson(this);
}