import 'package:techfrenetic/app/modules/courses/courses_page.dart';
import 'package:techfrenetic/app/modules/courses/courses_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/courses/lesson_page.dart';
import 'package:techfrenetic/app/providers/courses_provider.dart';
import 'package:techfrenetic/app/providers/video_provider.dart';

import 'course_page.dart';

class CoursesModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CoursesStore()),
    Bind.lazySingleton((i) => CoursesProvider()),
    Bind.lazySingleton((i) => VideoProvider()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const CoursesPage()),
    ChildRoute(
      "/:id",
      child: (_, args) => CoursePage(id: int.parse(args.params["id"])),
    ),
    ChildRoute(
      "/lesson",
      child: (context, args) => LessonPage(
        title: args.data["title"],
        video: args.data["video"],
        description: args.data["description"],
      ),
    )
  ];
}
