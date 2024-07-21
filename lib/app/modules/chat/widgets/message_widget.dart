import 'package:bubble/bubble.dart';
import 'package:cometchat/cometchat_sdk.dart';
import 'package:cometchat/models/action.dart' as cometchat;

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:techfrenetic/app/modules/chat/chat_store.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'avatar_chat_widget.dart';

class MessageWidget extends StatelessWidget {
  final BaseMessage message;

  const MessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    if (message is cometchat.Action) {
      return Center(
        child: Container(
          margin: const EdgeInsets.only(left: 20, top: 10),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.black12,
          ),
          child: Text(
            (message as cometchat.Action).message,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }

    if (message is TextMessage && (message as TextMessage).text.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _senderIsLoggedUser()
            ? Container(
                margin: const EdgeInsets.only(left: 20, top: 10),
                child: AvatarChatWidget(
                  url: message.sender?.avatar,
                ),
              )
            : const SizedBox.shrink(),
        Expanded(
          child: Bubble(
            margin: const BubbleEdges.symmetric(horizontal: 20, vertical: 10),
            nip: _senderIsLoggedUser() ? BubbleNip.leftTop : BubbleNip.rightTop,
            color: _senderIsLoggedUser() ? Colors.green[100] : Colors.blue[100],
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
                    message.sentAt != null
                        ? Text(
                            timeago.format(message.sentAt!, locale: 'en_short'),
                            style: Theme.of(context).textTheme.bodyText1)
                        : const SizedBox.shrink(),
                  ],
                ),
                message is TextMessage
                    ? Text((message as TextMessage).text)
                    : message is MediaMessage
                        ? _media(message as MediaMessage)
                        : const SizedBox.shrink()
              ],
            ),
          ),
        ),
        !_senderIsLoggedUser()
            ? Container(
                margin: const EdgeInsets.only(right: 20, top: 10),
                child: AvatarChatWidget(
                  url: message.sender?.avatar,
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  bool _senderIsLoggedUser() {
    ChatStore _chatStore = Modular.get();
    return _chatStore.loggedUser?.uid == message.sender?.uid;
  }

  Widget _media(MediaMessage mediaMessage) {
    if (mediaMessage.attachment != null &&
        mediaMessage.attachment!.fileExtension
            .toLowerCase()
            .contains(RegExp(r'\jpe?g|\png|\gif|\bmp|\webp'))) {
      return Center(
        child: Container(
          constraints: const BoxConstraints(maxHeight: 300, maxWidth: 400),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Image.network(
              mediaMessage.attachment!.fileUrl,
            ),
          ),
        ),
      );
    } else {
      return const Text("Unsupported media");
    }
  }
}
