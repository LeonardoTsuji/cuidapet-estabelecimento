import 'package:cuidapet_estabelecimento/app/models/agendamento_model.dart';
import 'package:cuidapet_estabelecimento/app/models/chat_iniciar_model.dart';
import 'package:cuidapet_estabelecimento/app/repository/agendamento_repository.dart';

class AgendamentoService {
  final AgendamentoRepository _repository;

  AgendamentoService(this._repository);

  Future<void> alterarStatusAgendamento(
      int idAgendamento, String status) async {
    await _repository.alterarStatusAgendamento(idAgendamento, status);
  }

  Future<List<AgendamentoModel>> buscarAgendamentos() {
    return _repository.buscarAgendamentos();
  }

  Future<ChatIniciarModel> iniciarChatAgendamento(int idAgendamento) async {
    return await _repository.iniciarChatAgendamento(idAgendamento);
  }
}
