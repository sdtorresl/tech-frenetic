import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class ArticlesController extends Disposable {
  final _controller = BehaviorSubject.seeded(0);

  ArticlesController() {
    counterStream = _controller.stream;
  }

  late Stream<int> counterStream;

  void increment() {
    _controller.add(_controller.value + 1);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
