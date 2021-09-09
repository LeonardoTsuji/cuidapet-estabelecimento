import 'package:cuidapet_estabelecimento/app/models/chat_fornecedor_model.dart';
import 'package:cuidapet_estabelecimento/app/services/chat_service.dart';
import 'package:mobx/mobx.dart';

part 'chat_lista_controller.g.dart';

class ChatListaController = _ChatListaControllerBase with _$ChatListaController;

abstract class _ChatListaControllerBase with Store {
  final ChatService _chatService;

  _ChatListaControllerBase(this._chatService);

  @observable
  ObservableFuture<List<ChatFornecedorModel>>? chatFuture;

  @action
  void findChats() {
    chatFuture = ObservableFuture(_chatService.buscarChatFornecedor());
  }
}
