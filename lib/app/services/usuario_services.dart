import 'package:cuidapet_estabelecimento/app/core/exceptions/cuidapet_exceptions.dart';
import 'package:cuidapet_estabelecimento/app/models/usuario_model.dart';
import 'package:cuidapet_estabelecimento/app/repository/secure_storage_repository.dart';
import 'package:cuidapet_estabelecimento/app/repository/shared_prefs_repository.dart';
import 'package:cuidapet_estabelecimento/app/repository/usuario_repository.dart';
import 'package:cuidapet_estabelecimento/app/models/access_token_model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UsuarioService {
  final UsuarioRepository _usuarioRepository;

  UsuarioService(this._usuarioRepository);

  Future<void> login(
    bool facebookLogin, {
    String? email,
    String? password,
  }) async {
    try {
      final prefs = await SharedPrefsRepository.instance;
      final firebaseAuth = FirebaseAuth.instance;
      AccessTokenModel acessTokenModel;

      if (!facebookLogin) {
        acessTokenModel = await _usuarioRepository.login(facebookLogin,
            email: email, password: password, avatar: '');
        await firebaseAuth.signInWithEmailAndPassword(
            email: email ?? '', password: password != null ? password : '');
        prefs.registerAccessToken(acessTokenModel.accessToken ?? '');
      }

      final confirmModel = await _usuarioRepository.confirmLogin();
      await prefs.registerAccessToken(confirmModel.accessToken);
      await SecureStorageRepository()
          .registerRefreshToken(confirmModel.accessToken);
      final dadosUsuario =
          await _usuarioRepository.recuperarDadosUsuarioLogado();
      await prefs.registerDadosUsuario(dadosUsuario);
    } on PlatformException catch (e) {
      print('Erro ao fazer login no Firebase $e');
      rethrow;
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        throw AcessoNegadoException(e.response?.data['mensagem'], e);
      } else {
        rethrow;
      }
    } catch (e) {
      print('Erro ao fazer login $e');
      rethrow;
    }
  }

  Future<void> cadastrarUsuario(String email, String senha) async {
    await _usuarioRepository.cadastrarUsuario(email, senha);
    var fireAuth = FirebaseAuth.instance;
    await fireAuth.createUserWithEmailAndPassword(
        email: email, password: senha);
  }

  Future<UsuarioModel> atualizarImagemPerfil(String urlImagem) {
    return _usuarioRepository.atualizarImagemPerfil(urlImagem);
  }
}
