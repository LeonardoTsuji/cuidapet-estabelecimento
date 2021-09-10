import 'package:cuidapet_estabelecimento/app/models/usuario_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:cuidapet_estabelecimento/app/models/fornecedor_model.dart';
import 'package:cuidapet_estabelecimento/app/models/fornecedor_servico_model.dart';

part 'agendamento_model.g.dart';

@JsonSerializable()
class AgendamentoModel {
  int id;
  String nome;
  String nomePet;
  String status;
  DateTime dataAgendamento;
  FornecedorModel fornecedor;
  UsuarioModel? usuario;
  List<FornecedorServicoModel> servicos;

  AgendamentoModel({
    required this.id,
    required this.nome,
    required this.nomePet,
    required this.status,
    required this.dataAgendamento,
    required this.fornecedor,
    required this.servicos,
    this.usuario,
  });

  factory AgendamentoModel.fromJson(Map<String, dynamic> json) =>
      _$AgendamentoModelFromJson(json);
  Map<String, dynamic> toJson() => _$AgendamentoModelToJson(this);
}
