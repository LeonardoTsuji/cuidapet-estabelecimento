import 'package:cuidapet_estabelecimento/app/repository/categorias_repository.dart';
import 'package:cuidapet_estabelecimento/app/services/categoria_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_controller.dart';

import 'home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeController(i(), i())),
    Bind.lazySingleton((i) => CategoriaRepository()),
    Bind.lazySingleton((i) => CategoriaService(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => HomePage()),
  ];
}
