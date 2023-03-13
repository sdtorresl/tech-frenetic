import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/chat/chat_store.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';

class ChatPage extends StatefulWidget {
  final String title;
  const ChatPage({Key? key, this.title = 'ChatPagePage'}) : super(key: key);
  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  ChatStore chatStore = Modular.get();

  @override
  void initState() {
    super.initState();
    chatStore.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TFAppBar(),
      body: Column(
        children: const <Widget>[],
      ),
    );
  }
}
