import 'package:appbarbearia_flutter/model/Role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  String id;
  String username;
  String password;
  Set<Role> roles;

  User();

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'username': username,
        'password': password,
        'roles': roles
      };

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        password = json['password'],
        roles = json['roles'];

}