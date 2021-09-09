import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:cuidapet_estabelecimento/app/models/agendamento_model.dart';
import 'package:cuidapet_estabelecimento/app/models/categorias_model.dart';
import 'package:cuidapet_estabelecimento/app/models/chat_fornecedor_model.dart';
import 'package:cuidapet_estabelecimento/app/models/chat_model.dart';
import 'package:cuidapet_estabelecimento/app/models/fornecedor_model.dart';
import 'package:cuidapet_estabelecimento/app/models/usuario_model.dart';
import 'package:cuidapet_estabelecimento/app/services/agendamento_servico.dart';
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
  Future<void> iniciarChatAgendamento(int idAgendamento) async {
    var loading;
    try {
      loading = LoadingIndicator.show();
      // await _agendamentoService.iniciarChatAgendamento(idAgendamento);
      Modular.to.pushNamed('/chat-lista/chat/',
          arguments: new ChatModel(
              id: 1,
              usuario: 1,
              nome: 'nome',
              nomePet: 'nomePet',
              fornecedor: FornecedorModel(
                  id: 1,
                  logo: '',
                  nome: '',
                  categoria: CategoriaModel(id: 1, nome: '', tipo: ''))));
      LoadingIndicator.hide(loading);
    } catch (e) {
      LoadingIndicator.hide(loading);
      AsukaSnackbar.warning("Erro ao iniciar chat").show();
    }
  }
}
