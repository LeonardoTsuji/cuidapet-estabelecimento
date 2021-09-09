import 'package:cuidapet_estabelecimento/app/models/categorias_model.dart';
import 'package:cuidapet_estabelecimento/app/models/endereco_model.dart';
import 'package:cuidapet_estabelecimento/app/models/fornecedor_busca_model.dart';
import 'package:cuidapet_estabelecimento/app/services/categoria_service.dart';
import 'package:cuidapet_estabelecimento/app/services/fornecedor_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  final CategoriaService _categoriaService;
  final FornecedorService _fornecedorService;
  final TextEditingController filtroNomeController = TextEditingController();

  @observable
  EnderecoModel? enderecoSelecionado;

  @observable
  ObservableFuture<List<CategoriaModel>>? categoriasFuture;

  @observable
  ObservableFuture<List<FornecedorBuscaModel>>? fornecedoresFuture;

  @observable
  List<FornecedorBuscaModel>? fornecedoresOriginais;

  @observable
  int paginaSelecionada = 0;

  @observable
  int? categoriaSelecionada;

  HomeControllerBase(
    this._categoriaService,
    this._fornecedorService,
  );

  @action
  Future<void> initPage() async {
    buscarCategorias();
    buscarFornecedores();
  }

  @action
  void alterarPaginaSelecionada(int pagina) => paginaSelecionada = pagina;

  @action
  void buscarCategorias() {
    categoriasFuture = ObservableFuture(_categoriaService.buscarCategorias());
  }

  @action
  Future<void> buscarFornecedores() async {
    categoriaSelecionada = null;
    filtroNomeController.text = '';
    fornecedoresFuture = ObservableFuture(
        _fornecedorService.buscarFornecedoresProximos(enderecoSelecionado));
    fornecedoresOriginais = await fornecedoresFuture;
  }

  @action
  void filtrarPorCategoria(int id) {
    if (categoriaSelecionada == id) {
      categoriaSelecionada = null;
    } else {
      categoriaSelecionada = id;
    }
    _filtrarFornecedores();
  }

  @action
  void filtrarFornecedoresPorNome() {
    _filtrarFornecedores();
  }

  @action
  void _filtrarFornecedores() {
    var fornecedores = fornecedoresOriginais;

    if (categoriaSelecionada != null) {
      fornecedores = fornecedores
          ?.where((element) => element.categoria.id == categoriaSelecionada)
          .toList();
    }

    if (filtroNomeController.text.isNotEmpty) {
      fornecedores = fornecedores
          ?.where((element) =>
              element.nome.toLowerCase().contains(filtroNomeController.text))
          .toList();
    }

    fornecedoresFuture = ObservableFuture(Future.value(fornecedores));
  }
}
