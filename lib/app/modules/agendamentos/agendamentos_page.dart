import 'package:cuidapet_estabelecimento/app/models/agendamento_model.dart';
import 'package:cuidapet_estabelecimento/app/modules/agendamentos/agendamentos_controller.dart';
import 'package:cuidapet_estabelecimento/app/shared/theme_utils.dart';
import 'package:cuidapet_estabelecimento/app/shared/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AgendamentosPage extends StatefulWidget {
  final String title;
  const AgendamentosPage({Key? key, this.title = 'AgendamentosPage'})
      : super(key: key);
  @override
  AgendamentosPageState createState() => AgendamentosPageState();
}

class AgendamentosPageState
    extends ModularState<AgendamentosPage, AgendamentosController> {
  @override
  void initState() {
    super.initState();
    controller.buscarAgendamentos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendamentos'),
      ),
      body: FutureBuilder<List<AgendamentoModel>>(
        future: controller.agendamentosFuture,
        builder: (_, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text('Erro ao buscar agendamentos'),
                );
              }
              if (snapshot.hasData) {
                var agendamentos = snapshot.data;

                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    var agendamento = agendamentos?[index];
                    return Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(Formatter.date('dd/MM/yyyy')
                                .format(agendamento!.dataAgendamento)),
                          ),
                          Card(
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        agendamento.fornecedor.logo),
                                  ),
                                  title: Text(agendamento.fornecedor.nome),
                                  subtitle: Text(controller
                                      .statusAgendamento[agendamento.status]!),
                                ),
                                Divider(),
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (_, index) {
                                    var servico = agendamento.servicos[index];
                                    return ListTile(
                                      leading: Icon(
                                        Icons.looks_one,
                                        color: ThemeUtils.primaryColor,
                                      ),
                                      title: Text(servico.nome),
                                    );
                                  },
                                  itemCount: agendamento.servicos.length,
                                ),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: () =>
                                            controller.alterarStatusAgendamento(
                                                agendamento.id, 'CN'),
                                        icon: Icon(Icons.done_outlined),
                                        tooltip: 'Aceitar',
                                        color: ThemeUtils.successColor,
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            controller.alterarStatusAgendamento(
                                                agendamento.id, 'P'),
                                        icon: Icon(Icons.pause),
                                        tooltip: 'Pendente',
                                        color: ThemeUtils.warningColor,
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            controller.alterarStatusAgendamento(
                                                agendamento.id, 'F'),
                                        icon: Icon(Icons.done_all_outlined),
                                        tooltip: 'Finalizar',
                                        color: ThemeUtils.primaryColor,
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            controller.alterarStatusAgendamento(
                                                agendamento.id, 'C'),
                                        icon: Icon(Icons.close),
                                        tooltip: 'Cancelar',
                                        color: ThemeUtils.errorColor,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton.icon(
                                          onPressed: () =>
                                              controller.iniciarChatAgendamento(
                                                  agendamento),
                                          icon: Icon(Icons.chat),
                                          style: ElevatedButton.styleFrom(
                                            primary:
                                                ThemeUtils.primaryColorDark,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),
                                          ),
                                          label: Text('Chat')),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: agendamentos?.length,
                );
              } else {
                return Center(
                  child: Text('Nenhum agendamento realizado'),
                );
              }

            default:
              return Container();
          }
        },
      ),
    );
  }
}
