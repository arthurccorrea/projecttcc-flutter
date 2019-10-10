import 'package:appbarbearia_flutter/model/Estados.dart';

import 'dart:convert';
import 'Barbeiro.dart';
import 'Promocao.dart';
import 'Servico.dart';

class Barbearia {
  String id;
  String nome;
  String descricao;
  String cidade;
  String endereco;
  Estados estado;
  int horaAbertura;
  int minutoAbertura;
  int horaFechamento;
  int minutoFechamento;
  DateTime horarioAbertura;
  DateTime horarioFechamento;
  DateTime cadastro;
  DateTime alterado;
  List<Servico> servicos;
  List<Barbeiro> barbeiros;
  List<Promocao> promocoes;

  Barbearia();

  Barbearia.construct(String id, String nome, String descricao,String cidade, String endereco, Estados estado, int horaAbertura, int minutoAbertura, int horaFechamento, int minutoFechamento){
    this.id = id;
    this. nome = nome;
    this.descricao = descricao;
    this.cidade = cidade;
    this.endereco = endereco;
    this.estado = estado;
    this.horaAbertura = horaAbertura;
    this.minutoAbertura = minutoAbertura;
    this.horaFechamento = horaFechamento;
    this.minutoAbertura = minutoAbertura;
  }

  Barbearia.constructForJson({this.id, this.nome, this.descricao, this.cidade, this.endereco, this.estado, this.horaAbertura, this.minutoAbertura, this.horaFechamento, this.minutoFechamento});

  factory Barbearia.fromJson(Map<String, dynamic> json){
    return Barbearia.constructForJson(
      id: json['id'], 
      nome: json['nome'],
      descricao: json['descricao'],
      cidade: json['cidade'],
      endereco: json['endereco'],
      estado: json['estado'],
      horaAbertura: json['horaAbertura'],
      minutoAbertura: json['minutoAbertura'],
      horaFechamento: json['horaFechamento'],
      minutoFechamento: json['minutoFechamento']);
  }

  String getId() {
    return id;
  }

  void setId(String id) {
    this.id = id;
  }

  String getNome() {
    return nome;
  }

  void setNome(String nome) {
    this.nome = nome;
  }

  String getDescricao() {
    return descricao;
  }

  void setDescricao(String descricao) {
    this.descricao = descricao;
  }

  String getCidade() {
    return cidade;
  }

  void setCidade(String cidade) {
    this.cidade = cidade;
  }

  String getEndereco() {
    return endereco;
  }

  void setEndereco(String endereco) {
    this.endereco = endereco;
  }

  Estados getEstado() {
    return estado;
  }

  void setEstado(Estados estado) {
    this.estado = estado;
  }

  int getHoraAbertura(){
    return horaAbertura;
  }

  void setHoraAbertura(int horaAbertura){
    this.horaAbertura = horaAbertura;
  }

  int getMinutoAbertura(){
    return minutoAbertura;
  }

  void setMinutoAbertura(int minutoAbertura){
    this.minutoAbertura = minutoAbertura;
  }

    int getHoraFechamento(){
    return horaFechamento;
  }

  void setHoraFechamento(int horaFechamento){
    this.horaFechamento = horaFechamento;
  }

  int getMinutoFechamento(){
    return minutoFechamento;
  }

  void setMinutoFechamento(int minutoFechamento){
    this.minutoFechamento = minutoFechamento;
  }


  DateTime getHorarioAbertura() {
    return horarioAbertura;
  }

  void setHorarioAbertura(DateTime horarioAbertura) {
    this.horarioAbertura = horarioAbertura;
  }

  DateTime getHorarioFechamento() {
    return horarioFechamento;
  }

  void setHorarioFechamento(DateTime horarioFechamento) {
    this.horarioFechamento = horarioFechamento;
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

  List<Servico> getServicos() {
    return servicos;
  }

  void setServicos(List<Servico> servicos) {
    this.servicos = servicos;
  }

  List<Barbeiro> getBarbeiros() {
    return barbeiros;
  }

  void setBarbeiros(List<Barbeiro> barbeiros) {
    this.barbeiros = barbeiros;
  }

  List<Promocao> getPromocoes() {
    return promocoes;
  }

  void setPromocoes(List<Promocao> promocoes) {
    this.promocoes = promocoes;
  }
}
