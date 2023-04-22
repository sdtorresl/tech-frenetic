import 'package:cometchat/cometchat_sdk.dart';
import 'package:flutter/material.dart';
import 'package:techfrenetic/app/modules/chat/widgets/avatar_chat_widget.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';

class MessagingPage extends StatefulWidget {
  final User user;
  const MessagingPage({super.key, required this.user});

  @override
  State<MessagingPage> createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TFAppBar(
        title: Row(
          children: [
            AvatarChatWidget(url: widget.user.avatar),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.name,
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text('Fuera de linea',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
      body: const Center(
          child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          'Aún no has iniciado una conversación con este usuario. ¡Dile "Hola"!',
          textAlign: TextAlign.center,
        ),
      )),
      bottomNavigationBar: _messageInput(),
    );
  }

  Widget _messageInput() {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black12),
          borderRadius: BorderRadius.circular(10),
          color: Colors.black12,
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: Colors.black12, width: 1),
                  top: BorderSide(color: Colors.black12, width: 1),
                  left: BorderSide(color: Colors.black12, width: 1),
                  right: BorderSide(color: Colors.black12, width: 1),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: const Text(
                'Introduce tu mensaje aquí',
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Flexible(
                    child: SizedBox(
                      height: 40,
                      child: TextField(),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.send_outlined),
                  )
                ],
              ),
            )
          ],
        ),
        margin: const EdgeInsets.all(20),
      ),
    );
  }
}
