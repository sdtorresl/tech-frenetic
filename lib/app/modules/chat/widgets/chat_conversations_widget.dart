import 'package:cometchat/cometchat_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../chat_store.dart';
import 'avatar_chat_widget.dart';

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
    _chatStore.getConversations();
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
            if (_chatStore.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: _chatStore.conversations.length,
              itemBuilder: (context, index) {
                AppEntity entity =
                    _chatStore.conversations[index].conversationWith;
                final title =
                    entity is Group ? (entity).name : (entity as User).name;

                return ListTile(
                  leading: AvatarChatWidget(
                      url: entity is Group
                          ? entity.icon
                          : (entity as User).avatar),
                  title: Text(title),
                  onTap: () => Modular.to.pushNamed(
                    entity is Group ? '/chat/group' : '/chat/message',
                    arguments: entity,
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
