import 'package:cuidapet_estabelecimento/app/models/chat_fornecedor_model.dart';
import 'package:cuidapet_estabelecimento/app/models/chat_message_model.dart';
import 'package:cuidapet_estabelecimento/app/models/chat_model.dart';
import 'package:cuidapet_estabelecimento/app/repository/chat_repository.dart';

class ChatService {
  final ChatRepository _repository;

  ChatService(this._repository);

  Future<List<ChatFornecedorModel>> buscarChatFornecedor() {
    return _repository.buscarChatFornecedor();
  }

  Stream<List<ChatMessageModel>> getMessages(ChatModel? chat) {
    return _repository.getMessages(chat);
  }

  void sendMessage(ChatModel model, String mensagem) {
    _repository.sendMessage(model, mensagem);
    _repository.notificarUsuario(model, mensagem);
  }
}
