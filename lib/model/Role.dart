import 'package:json_annotation/json_annotation.dart';

part 'Role.g.dart';

@JsonSerializable()
class Role {
  String id;
  String name;

  Role();

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}