import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class SearchController extends Disposable {
  final _searchController = BehaviorSubject<String>.seeded("");

  Stream<String> get commentStream => _searchController.stream;

  Function(String) get changeComment => _searchController.sink.add;

  String get comment => _searchController.value;

  @override
  void dispose() {
    _searchController.close();
  }
}
