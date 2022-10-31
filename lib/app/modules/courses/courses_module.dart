import 'package:techfrenetic/app/modules/courses/courses_page.dart';
import 'package:techfrenetic/app/modules/courses/courses_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/providers/courses_provider.dart';

class CoursesModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CoursesStore()),
    Bind.lazySingleton((i) => CoursesProvider()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const CoursesPage()),
  ];
}
