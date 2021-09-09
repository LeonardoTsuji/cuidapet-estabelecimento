import 'package:cuidapet_estabelecimento/app/models/chat_model.dart';
import 'package:cuidapet_estabelecimento/app/models/usuario_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:cuidapet_estabelecimento/app/models/fornecedor_model.dart';

part 'chat_fornecedor_model.g.dart';

@JsonSerializable()
class ChatFornecedorModel {
  int id;
  UsuarioModel usuario;
  String nome;
  @JsonKey(name: 'nome_pet')
  String nomePet;
  FornecedorModel fornecedor;

  ChatFornecedorModel({
    required this.id,
    required this.usuario,
    required this.nome,
    required this.nomePet,
    required this.fornecedor,
  });

  factory ChatFornecedorModel.fromJson(Map<String, dynamic> json) =>
      _$ChatFornecedorModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatFornecedorModelToJson(this);

  ChatModel toChatModel(ChatFornecedorModel chatFornecedorModel) {
    return ChatModel(
        nome: chatFornecedorModel.nome,
        id: chatFornecedorModel.id,
        fornecedor: fornecedor,
        nomePet: chatFornecedorModel.nomePet,
        usuario: chatFornecedorModel.usuario.id!);
  }
}
