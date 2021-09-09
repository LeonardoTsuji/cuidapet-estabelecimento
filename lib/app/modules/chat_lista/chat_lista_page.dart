import 'package:cuidapet_estabelecimento/app/models/chat_fornecedor_model.dart';
import 'package:cuidapet_estabelecimento/app/modules/chat_lista/chat_lista_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChatListaPage extends StatefulWidget {
  final String title;
  const ChatListaPage({Key? key, this.title = 'ChatListaPage'})
      : super(key: key);
  @override
  ChatListaPageState createState() => ChatListaPageState();
}

class ChatListaPageState
    extends ModularState<ChatListaPage, ChatListaController> {
  @override
  void initState() {
    super.initState();
    controller.findChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: Observer(builder: (_) {
        return FutureBuilder<List<ChatFornecedorModel>>(
          future: controller.chatFuture,
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
                    child: Text('Erro ao buscar chats'),
                  );
                }
                if (snapshot.hasData && snapshot.data!.length > 0) {
                  var chats = snapshot.data;

                  return ListView.separated(
                      itemBuilder: (_, index) {
                        var chat = chats?[index];
                        return ListTile(
                          onTap: () => Modular.to.pushNamed('/chat-lista/chat/',
                              arguments: chat!.toChatModel(chat)),
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(chat?.usuario.imgAvatar ?? ''),
                          ),
                          title: Text(chat?.nome ?? ''),
                          subtitle: Text(chat?.nomePet ?? ''),
                        );
                      },
                      separatorBuilder: (_, __) => Divider(),
                      itemCount: chats?.length ?? 0);
                } else {
                  return Center(
                    child: Text('Nenhum chat encontrado'),
                  );
                }

              default:
                return Container();
            }
          },
        );
      }),
    );
  }
}
