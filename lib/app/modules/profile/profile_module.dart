import 'package:techfrenetic/app/core/custom_transition.dart';
import 'package:techfrenetic/app/modules/profile/my_activity/my_activity_page.dart';
import 'package:techfrenetic/app/modules/profile/my_content/my_content_page.dart';
import 'package:techfrenetic/app/modules/profile/my_profile/my_profile_page.dart';
import 'package:techfrenetic/app/modules/profile/profile_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/profile/saved_articles/my_saved_articles_page.dart';

import 'my_account/my_account_module.dart';

class ProfileModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SingUpController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const ProfilePage(),
      transition: TransitionType.custom,
      customTransition: myCustomTransition,
      children: [
        ChildRoute(
          '/profile',
          child: (context, args) => MyProfilePage(),
        ),
        ChildRoute('/content', child: (context, args) => const MyContentPage()),
        ChildRoute('/activity',
            child: (context, args) => const MyActivityPage()),
        ChildRoute('/saved-articles',
            child: (context, args) => const MySavedArticlesPage()),
        ModuleRoute(
          '/my-account',
          module: MyAccountModule(),
        ),
      ],
    ),
  ];
}

class SingUpController {}
