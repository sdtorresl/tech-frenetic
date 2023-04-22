import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/modules/chat/widgets/avatar_chat_widget.dart';

import '../chat_store.dart';

class ChatUsersWidget extends StatefulWidget {
  const ChatUsersWidget({super.key});

  @override
  State<ChatUsersWidget> createState() => _ChatUsersWidgetState();
}

class _ChatUsersWidgetState extends State<ChatUsersWidget> {
  final ChatStore _chatStore = Modular.get();
  final TextEditingController _searchController = TextEditingController();

  String? filter;

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
              itemCount: _chatStore.users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: AvatarChatWidget(
                    url: _chatStore.users[index].avatar,
                  ),
                  title: Text(_chatStore.users[index].name),
                  onTap: () => Modular.to.pushNamed('/chat/message',
                      arguments: _chatStore.users[index]),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
