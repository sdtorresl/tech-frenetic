import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../chat_store.dart';

class ChatConversationsWidget extends StatefulWidget {
  const ChatConversationsWidget({super.key});

  @override
  State<ChatConversationsWidget> createState() =>
      _ChatConversationsWidgetState();
}

class _ChatConversationsWidgetState extends State<ChatConversationsWidget> {
  final ChatStore _chatStore = Modular.get();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _chatStore.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              labelText: AppLocalizations.of(context)?.search ?? '',
            ),
          ),
        ),
        Expanded(
          child: Observer(builder: (context) {
            return ListView.builder(
              itemCount: _chatStore.conversations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  // leading: AvatarChatWidget(
                  //   url: _chatStore.conversations[index].,
                  // ),
                  title: Text(_chatStore.conversations[index].toString()),
                  onTap: () => Modular.to.pushNamed('/chat/message',
                      arguments: _chatStore.conversations[index]),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
