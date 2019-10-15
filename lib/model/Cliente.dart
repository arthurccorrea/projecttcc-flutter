
import 'package:appbarbearia_flutter/model/Estados.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Cliente.g.dart';

@JsonSerializable()
class Cliente {
  String id;
  String cidade;
  String endereco;
  Estados estado;
  String nome;
  String cpf;
  String telefone;
  String celular;
  //	URL
  String foto;
  DateTime dataNascimento;
  DateTime cadastro;
  DateTime alterado;


  Cliente();

  factory Cliente.fromJson(Map<String, dynamic> json) => _$ClienteFromJson(json);

  Map<String, dynamic> toJson() => _$ClienteToJson(this);

}
