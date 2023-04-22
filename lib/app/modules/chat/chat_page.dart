import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/chat/chat_store.dart';
import 'package:techfrenetic/app/modules/chat/widgets/chat_conversations_widget.dart';
import 'package:techfrenetic/app/modules/chat/widgets/chat_users_widget.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';

class ChatPage extends StatefulWidget {
  final String title;
  const ChatPage({Key? key, this.title = 'Chat Page'}) : super(key: key);
  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  ChatStore chatStore = Modular.get();
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    chatStore.initialize();
  }

  static const List<String> _titles = ['Chats', 'Usuarios', 'Grupos'];

  static const List<Widget> _pages = <Widget>[
    ChatConversationsWidget(),
    ChatUsersWidget(),
    ChatUsersWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TFAppBar(
        title: Text(
          _titles[_selectedIndex],
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ),
      bottomNavigationBar: _chatButtomNavigationBar(),
      backgroundColor: Colors.white,
    );
  }

  Widget _chatButtomNavigationBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline_outlined), label: 'Chats'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined), label: 'Usuarios'),
        BottomNavigationBarItem(
            icon: Icon(Icons.group_outlined), label: 'Grupos'),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
