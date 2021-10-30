import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/models/articles_model.dart';
import 'package:techfrenetic/app/modules/articles/articles_controller.dart';

class ArticlesPage extends StatefulWidget {
  final ArticlesModel article;
  const ArticlesPage({Key? key, required this.article}) : super(key: key);
  @override
  ArticlesPageState createState() => ArticlesPageState();
}

class ArticlesPageState extends ModularState<ArticlesPage, ArticlesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article.title),
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder(
            stream: store.counterStream,
            initialData: 0,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.toString());
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          ElevatedButton(
              onPressed: () => store.increment(),
              child: const Text("Increment"))
        ],
      ),
    );
  }
}
