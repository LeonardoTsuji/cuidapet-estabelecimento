import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:cuidapet_estabelecimento/app/models/agendamento_model.dart';
import 'package:cuidapet_estabelecimento/app/models/chat_model.dart';
import 'package:cuidapet_estabelecimento/app/services/agendamento_service.dart';
import 'package:cuidapet_estabelecimento/app/shared/components/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'agendamentos_controller.g.dart';

class AgendamentosController = _AgendamentosControllerBase
    with _$AgendamentosController;

abstract class _AgendamentosControllerBase with Store {
  final AgendamentoService _agendamentoService;

  _AgendamentosControllerBase(this._agendamentoService);

  var statusAgendamento = {
    'P': 'Pendente',
    'CN': 'Confirmada',
    'F': 'Finalizada',
    'C': 'Cancelada',
  };

  @observable
  ObservableFuture<List<AgendamentoModel>>? agendamentosFuture;

  @action
  void buscarAgendamentos() {
    agendamentosFuture =
        ObservableFuture(_agendamentoService.buscarAgendamentos());
  }

  @action
  Future<void> alterarStatusAgendamento(
      int idAgendamento, String status) async {
    var loading;
    try {
      loading = LoadingIndicator.show();
      await _agendamentoService.alterarStatusAgendamento(idAgendamento, status);
      LoadingIndicator.hide(loading);
      AsukaSnackbar.success(
              'Agendamento ${statusAgendamento[idAgendamento]} com sucesso!')
          .show();
      Future.delayed(
          Duration(seconds: 2),
          () async => await Modular.to.pushNamedAndRemoveUntil(
              '/agendamentos', ModalRoute.withName('/agendamentos')));
    } catch (e) {
      LoadingIndicator.hide(loading);
      AsukaSnackbar.warning("Erro ao alterar status do agendamento").show();
    }
  }

  @action
  Future<void> iniciarChatAgendamento(AgendamentoModel agendamentoModel) async {
    var loading;
    try {
      loading = LoadingIndicator.show();
      var chatIniciado =
          await _agendamentoService.iniciarChatAgendamento(agendamentoModel.id);
      await Modular.to.pushNamed('/chat-lista/chat/',
          arguments: ChatModel(
            id: chatIniciado.id,
            usuario: agendamentoModel.usuario?.id ?? 0,
            nome: agendamentoModel.nome,
            nomePet: agendamentoModel.nomePet,
            fornecedor: agendamentoModel.fornecedor,
          ));
      LoadingIndicator.hide(loading);
    } catch (e) {
      LoadingIndicator.hide(loading);
      AsukaSnackbar.warning("Erro ao iniciar chat").show();
    }
  }
}
