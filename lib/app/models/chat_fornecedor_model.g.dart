// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_fornecedor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatFornecedorModel _$ChatFornecedorModelFromJson(Map<String, dynamic> json) {
  return ChatFornecedorModel(
    id: json['id'] as int,
    usuario: UsuarioModel.fromJson(json['usuario'] as Map<String, dynamic>),
    nome: json['nome'] as String,
    nomePet: json['nome_pet'] as String,
    fornecedor:
        FornecedorModel.fromJson(json['fornecedor'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ChatFornecedorModelToJson(
        ChatFornecedorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'usuario': instance.usuario,
      'nome': instance.nome,
      'nome_pet': instance.nomePet,
      'fornecedor': instance.fornecedor,
    };
