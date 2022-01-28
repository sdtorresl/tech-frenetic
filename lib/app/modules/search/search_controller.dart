import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class SearchController extends Disposable {
  final _searchController = BehaviorSubject<String>.seeded("");

  Stream<String> get searchStream => _searchController.stream;

  Function(String) get changeSearch => _searchController.sink.add;

  String get search => _searchController.value;

  @override
  void dispose() {
    _searchController.close();
  }
}
