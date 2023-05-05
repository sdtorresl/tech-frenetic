import 'package:bubble/bubble.dart';
import 'package:cometchat/cometchat_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:techfrenetic/app/modules/chat/messaging_store.dart';
import 'package:techfrenetic/app/modules/chat/widgets/avatar_chat_widget.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatGroupPage extends StatefulWidget {
  final Group group;
  const ChatGroupPage({super.key, required this.group});

  @override
  State<ChatGroupPage> createState() => _ChatGroupPageState();
}

class _ChatGroupPageState extends State<ChatGroupPage> {
  final MessagingStore _messagingStore = MessagingStore();

  @override
  void initState() {
    _messagingStore.getMessages(widget.group.guid, groupMessages: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TFAppBar(
        title: Row(
          children: [
            AvatarChatWidget(url: widget.group.icon),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.group.name,
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(
                    "${widget.group.membersCount} ${AppLocalizations.of(context)?.groups_members ?? ''}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
      body: _messagesList(),
      bottomNavigationBar: _messageInput(),
    );
  }

  Widget _messagesList() {
    return FutureBuilder(
      future:
          _messagingStore.getMessages(widget.group.guid, groupMessages: true),
      builder: (BuildContext context, snapshot) {
        if (_messagingStore.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (_messagingStore.messages.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Aún no has iniciado una conversación en este grupo. Di "Hola"!',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        return Observer(builder: (context) {
          return ListView.builder(
            itemCount: _messagingStore.messages.length,
            itemBuilder: (context, index) {
              return _messageBubble(_messagingStore.messages[index]);
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

  Widget _messageBubble(BaseMessage message) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, top: 10),
          child: AvatarChatWidget(
            url: message.sender?.avatar,
          ),
        ),
        Expanded(
          child: Bubble(
            margin: const BubbleEdges.symmetric(horizontal: 20, vertical: 10),
            nip: BubbleNip.leftTop,
            color: Theme.of(context).backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        message.sender?.name ?? '',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: SvgPicture.asset(
                        'assets/img/icons/dot.svg',
                        allowDrawingOutsideViewBox: true,
                        semanticsLabel: 'Dot',
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    message.deliveredAt != null
                        ? Text(
                            timeago.format(message.deliveredAt!,
                                locale: 'en_short'),
                            style: Theme.of(context).textTheme.bodyText1)
                        : const SizedBox.shrink(),
                  ],
                ),
                message is TextMessage
                    ? Text((message).text)
                    : const Text("Media message")
              ],
            ),
          ),
        )
      ],
    );
  }

  void sendMessage() {
    _messagingStore.sendMessage(
      receiverID: widget.group.guid,
      receiverType: CometChatReceiverType.group,
    );
  }
}
