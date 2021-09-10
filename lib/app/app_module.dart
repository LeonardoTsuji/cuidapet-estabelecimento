import 'package:cuidapet_estabelecimento/app/core/connection/connection_error.dart';
import 'package:cuidapet_estabelecimento/app/core/database/connection_adm.dart';
import 'package:cuidapet_estabelecimento/app/modules/chat_lista/chat_lista_module.dart';
import 'package:cuidapet_estabelecimento/app/modules/estabelecimento/estabelecimento_module.dart';
import 'package:cuidapet_estabelecimento/app/modules/home/home_module.dart';
import 'package:cuidapet_estabelecimento/app/modules/main_page.dart';
import 'package:cuidapet_estabelecimento/app/modules/agendamentos/agendamentos_module.dart';
import 'package:cuidapet_estabelecimento/app/repository/agendamento_repository.dart';
import 'package:cuidapet_estabelecimento/app/repository/fornecedor_repository.dart';
import 'package:cuidapet_estabelecimento/app/repository/usuario_repository.dart';
import 'package:cuidapet_estabelecimento/app/services/agendamento_service.dart';
import 'package:cuidapet_estabelecimento/app/services/fornecedor_service.dart';
import 'package:cuidapet_estabelecimento/app/services/usuario_services.dart';
import 'package:cuidapet_estabelecimento/app/shared/auth_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/login/login_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind(
      (i) => ConnectionAdm(),
      isLazy: false,
    ),
    Bind(
      (i) => AuthStore(),
    ),
    Bind(
      (i) => UsuarioRepository(),
    ),
    Bind(
      (i) => UsuarioService(i()),
    ),
    Bind(
      (i) => FornecedorRepository(),
    ),
    Bind(
      (i) => FornecedorService(i()),
    ),
    Bind(
      (i) => AgendamentoRepository(),
    ),
    Bind(
      (i) => AgendamentoService(i()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => MainPage(),
    ),
    ModuleRoute(
      '/login',
      module: LoginModule(),
    ),
    ModuleRoute(
      '/home',
      module: HomeModule(),
    ),
    ModuleRoute(
      '/estabelecimento',
      module: EstabelecimentoModule(),
    ),
    ModuleRoute(
      '/agendamentos',
      module: AgendamentosModule(),
    ),
    ModuleRoute(
      '/chat-lista',
      module: ChatListaModule(),
    ),
    ChildRoute(
      '/connection-error',
      child: (context, args) => ConnectionError(),
    )
  ];
}
