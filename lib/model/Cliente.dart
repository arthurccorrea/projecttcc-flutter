
import 'package:appbarbearia_flutter/model/Estados.dart';

class Cliente {
  String id;
  String cidade;
  String endereco;
  Estados estado;
  String nome;
  String cpf;
  int telefone;
  int celular;
  //	URL
  String foto;
  DateTime dataNascimento;
  DateTime cadastro;
  DateTime alterado;

  String getId() {
    return id;
  }

  void setId(String id) {
    this.id = id;
  }

  String getCidade() {
    return cidade;
  }

  void setCidade(String cidade) {
    this.cidade = cidade;
  }

  String getEndereco(){
    return endereco;
  }

  void setEndereco(String endereco){
    this.endereco = endereco;
  }

  Estados getEstado(){
    return estado;
  }

  void setEstado(Estados estado){
    this.estado = estado;
  }

  String getNome() {
    return nome;
  }

  void setNome(String nome) {
    this.nome = nome;
  }

  String getCpf() {
    return cpf;
  }

  void setCpf(String cpf) {
    this.cpf = cpf;
  }

  int getTelefone() {
    return telefone;
  }

  void setTelefone(int telefone) {
    this.telefone = telefone;
  }

  int getCelular() {
    return celular;
  }

  void setCelular(int celular) {
    this.celular = celular;
  }

  String getFoto() {
    return foto;
  }

  void setFoto(String foto) {
    this.foto = foto;
  }

  DateTime getDataNascimento() {
    return dataNascimento;
  }

  void setDataNascimento(DateTime dataNascimento) {
    this.dataNascimento = dataNascimento;
  }

  DateTime getCadastro() {
    return cadastro;
  }

  void setCadastro(DateTime cadastro) {
    this.cadastro = cadastro;
  }

  DateTime getAlterado() {
    return alterado;
  }

  void setAlterado(DateTime alterado) {
    this.alterado = alterado;
  }
}
