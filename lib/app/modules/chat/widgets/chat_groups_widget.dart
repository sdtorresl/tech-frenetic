import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/modules/chat/widgets/avatar_chat_widget.dart';

import '../chat_store.dart';

class ChatGroupsWidget extends StatefulWidget {
  const ChatGroupsWidget({super.key});

  @override
  State<ChatGroupsWidget> createState() => _ChatGroupsWidgetState();
}

class _ChatGroupsWidgetState extends State<ChatGroupsWidget> {
  final ChatStore _chatStore = Modular.get();

  String? filter;

  @override
  void initState() {
    super.initState();
    _chatStore.getGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: TextField(
            controller: _chatStore.groupsSearchEditingController,
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
              itemCount: _chatStore.groups.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: AvatarChatWidget(
                    url: _chatStore.groups[index].icon,
                  ),
                  title: Text(_chatStore.groups[index].name),
                  subtitle: Text(
                    "${_chatStore.groups[index].membersCount} members",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(fontSize: 12, color: Colors.grey),
                  ),
                  onTap: () => Modular.to.pushNamed(
                    '/chat/group',
                    arguments: _chatStore.groups[index],
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
