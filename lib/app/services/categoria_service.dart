import 'package:cuidapet_estabelecimento/app/models/categorias_model.dart';
import 'package:cuidapet_estabelecimento/app/repository/categorias_repository.dart';

class CategoriaService {
  final CategoriaRepository _repository;

  CategoriaService(this._repository);

  Future<List<CategoriaModel>> buscarCategorias() {
    return _repository.buscarCategorias();
  }
}
