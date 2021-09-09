import 'package:cuidapet_estabelecimento/app/modules/agendamentos/agendamentos_controller.dart';
import 'package:cuidapet_estabelecimento/app/modules/agendamentos/agendamentos_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AgendamentosModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AgendamentosController(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => AgendamentosPage()),
  ];
}
