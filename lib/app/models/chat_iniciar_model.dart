import 'package:json_annotation/json_annotation.dart';

part 'chat_iniciar_model.g.dart';

@JsonSerializable()
class ChatIniciarModel {
  int id;

  ChatIniciarModel({
    required this.id,
  });

  factory ChatIniciarModel.fromJson(Map<String, dynamic> json) =>
      _$ChatIniciarModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatIniciarModelToJson(this);
}
