import 'package:cometchat/cometchat_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:techfrenetic/app/modules/chat/messaging_store.dart';
import 'package:techfrenetic/app/modules/chat/widgets/avatar_chat_widget.dart';
import 'package:techfrenetic/app/modules/chat/widgets/message_widget.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MessagingPage extends StatefulWidget {
  final AppEntity entity;
  const MessagingPage({super.key, required this.entity});

  @override
  State<MessagingPage> createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  final MessagingStore _messagingStore = MessagingStore();

  @override
  void initState() {
    _messagingStore.initializeListeners(widget.entity);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.entity is User ? _usersHeader() : _groupHeader(),
      body: _messagesList(),
      bottomNavigationBar: _messageInput(),
    );
  }

  PreferredSizeWidget _groupHeader() {
    Group group = (widget.entity as Group);

    return TFAppBar(
      title: Row(
        children: [
          AvatarChatWidget(url: group.icon),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                group.name,
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                  "${group.membersCount} ${AppLocalizations.of(context)?.groups_members ?? ''}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _usersHeader() {
    User user = (widget.entity as User);
    return TFAppBar(
      title: Row(
        children: [
          AvatarChatWidget(url: user.avatar),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(user.status ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _messagesList() {
    return FutureBuilder(
      future: _messagingStore.getMessages(widget.entity),
      builder: (BuildContext context, snapshot) {
        if (_messagingStore.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (_messagingStore.messages.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                widget.entity is User
                    ? 'Aún no has iniciado una conversación con este usuario. ¡Dile "Hola"!'
                    : 'Aún no has iniciado una conversación en este grupo. Di "Hola"!',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        return Observer(builder: (context) {
          return ListView.builder(
            controller: _messagingStore.scrollController,
            itemCount: _messagingStore.messages.length,
            itemBuilder: (context, index) {
              BaseMessage message = _messagingStore.messages[index];
              return MessageWidget(message: message);
            },
          );
        });
      },
    );
  }

  Widget _messageInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: SafeArea(
        child: Row(
          children: [
            Flexible(
              child: TextField(
                keyboardType: TextInputType.multiline,
                decoration:
                    const InputDecoration(hintText: 'Enter your message here'),
                controller: _messagingStore.messageEditingController,
                //onSubmitted: (value) => submitComment(),
              ),
            ),
            IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.send_outlined),
            )
          ],
        ),
      ),
    );
  }

  void sendMessage() {
    if (widget.entity is User) {
      _messagingStore.sendMessage(receiverID: (widget.entity as User).uid);
    }
    if (widget.entity is Group) {
      _messagingStore.sendMessage(
        receiverID: (widget.entity as Group).guid,
        receiverType: CometChatReceiverType.group,
      );
    }
  }
}
