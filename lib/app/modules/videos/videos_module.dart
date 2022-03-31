import 'package:techfrenetic/app/modules/videos/preview_page.dart';
import 'package:techfrenetic/app/modules/videos/videos_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/videos/videos_page.dart';

class VideosModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => VideosController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const VideosPage(),
    ),
    ChildRoute(
      '/preview',
      child: (_, args) => PreviewPage(videoFile: args.data),
    )
  ];
}
