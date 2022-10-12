import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class PostBoxController extends Disposable {
  final _postController = BehaviorSubject<String>();

  Stream<String> get postStream => _postController.stream;

  Function(String) get changePost => _postController.sink.add;

  String get post => _postController.value;

  @override
  void dispose() {
    _postController.close();
  }
}
