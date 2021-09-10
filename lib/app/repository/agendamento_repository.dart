import 'package:cuidapet_estabelecimento/app/core/dio/custom_dio.dart';
import 'package:cuidapet_estabelecimento/app/models/agendamento_model.dart';
import 'package:cuidapet_estabelecimento/app/models/chat_iniciar_model.dart';

class AgendamentoRepository {
  Future<void> alterarStatusAgendamento(int idAgendamento, String status) {
    return CustomDio.authInstance
        .put('/agendamento/$idAgendamento/status/$status');
  }

  Future<List<AgendamentoModel>> buscarAgendamentos() {
    return CustomDio.authInstance.get('/agendamentos/fornecedor').then(
        (value) => value.data
            .map<AgendamentoModel>(
                (agendamento) => AgendamentoModel.fromJson(agendamento))
            .toList());
  }

  Future<ChatIniciarModel> iniciarChatAgendamento(int idAgendamento) {
    return CustomDio.authInstance
        .post('/agendamento/$idAgendamento/iniciar-chat')
        .then((value) => ChatIniciarModel.fromJson(value.data));
  }
}
