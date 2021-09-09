import 'package:cuidapet_estabelecimento/app/core/dio/custom_dio.dart';
import 'package:cuidapet_estabelecimento/app/models/categorias_model.dart';

class CategoriaRepository {
  Future<List<CategoriaModel>> buscarCategorias() {
    return CustomDio.authInstance.get('/categorias').then((value) => value.data
        .map<CategoriaModel>((c) => CategoriaModel.fromJson(c))
        .toList());
  }
}
