import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/articles/articles_module.dart';
import 'package:techfrenetic/app/modules/community/community_module.dart';
import 'package:techfrenetic/app/modules/login/login_module.dart';
import 'package:techfrenetic/app/modules/profile/profile_page.dart';

import 'package:techfrenetic/app/modules/sign_up/sign_up_module.dart';
import 'package:techfrenetic/app/modules/sign_up/sign_up_page.dart';

import 'package:techfrenetic/app/modules/events/events_page.dart';


import 'home_controller.dart';
import 'home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const HomePage(),
      children: [
        ModuleRoute('/community/', module: CommunityModule()),
        ChildRoute(
          '/skills',
          child: (context, args) => const EventsPage(),
        ),
        ChildRoute(
          '/vendors',
          child: (context, args) => const Text("Vendors"),
        ),
        ChildRoute(
          '/profile',
          child: (context, args) => const ProfilePage(),
        ),
      ],
    ),
    ModuleRoute('/community/article', module: ArticlesModule()),
    ModuleRoute('/login', module: LoginModule()),
    ModuleRoute('/sign', module: SignUpModule()),
  ];
}
