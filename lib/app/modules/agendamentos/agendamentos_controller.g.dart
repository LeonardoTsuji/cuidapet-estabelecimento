// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agendamentos_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AgendamentosController on _AgendamentosControllerBase, Store {
  final _$agendamentosFutureAtom =
      Atom(name: '_AgendamentosControllerBase.agendamentosFuture');

  @override
  ObservableFuture<List<AgendamentoModel>>? get agendamentosFuture {
    _$agendamentosFutureAtom.reportRead();
    return super.agendamentosFuture;
  }

  @override
  set agendamentosFuture(ObservableFuture<List<AgendamentoModel>>? value) {
    _$agendamentosFutureAtom.reportWrite(value, super.agendamentosFuture, () {
      super.agendamentosFuture = value;
    });
  }

  final _$alterarStatusAgendamentoAsyncAction =
      AsyncAction('_AgendamentosControllerBase.alterarStatusAgendamento');

  @override
  Future<void> alterarStatusAgendamento(int idAgendamento, String status) {
    return _$alterarStatusAgendamentoAsyncAction
        .run(() => super.alterarStatusAgendamento(idAgendamento, status));
  }

  final _$iniciarChatAgendamentoAsyncAction =
      AsyncAction('_AgendamentosControllerBase.iniciarChatAgendamento');

  @override
  Future<void> iniciarChatAgendamento(AgendamentoModel agendamentoModel) {
    return _$iniciarChatAgendamentoAsyncAction
        .run(() => super.iniciarChatAgendamento(agendamentoModel));
  }

  final _$_AgendamentosControllerBaseActionController =
      ActionController(name: '_AgendamentosControllerBase');

  @override
  void buscarAgendamentos() {
    final _$actionInfo = _$_AgendamentosControllerBaseActionController
        .startAction(name: '_AgendamentosControllerBase.buscarAgendamentos');
    try {
      return super.buscarAgendamentos();
    } finally {
      _$_AgendamentosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
agendamentosFuture: ${agendamentosFuture}
    ''';
  }
}
