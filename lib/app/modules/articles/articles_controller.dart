import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class ArticlesController extends Disposable {
  final _commentController = BehaviorSubject<String>.seeded("");

  Stream<String> get commentStream => _commentController.stream;

  Function(String) get changeComment => _commentController.sink.add;

  String get comment => _commentController.value;

  @override
  void dispose() {
    _commentController.close();
  }
}
