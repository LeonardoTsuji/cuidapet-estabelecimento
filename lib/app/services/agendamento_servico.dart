import 'package:cuidapet_estabelecimento/app/models/agendamento_model.dart';
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

  Future<void> iniciarChatAgendamento(int idAgendamento) async {
    await _repository.iniciarChatAgendamento(idAgendamento);
  }
}
