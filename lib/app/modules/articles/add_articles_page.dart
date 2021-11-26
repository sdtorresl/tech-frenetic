import 'package:flutter/material.dart';

class AddArticlesPage extends StatefulWidget {
  final String title;
  const AddArticlesPage({Key? key, this.title = 'AddArticlesPage'}) : super(key: key);
  @override
  AddArticlesPageState createState() => AddArticlesPageState();
}
class AddArticlesPageState extends State<AddArticlesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}