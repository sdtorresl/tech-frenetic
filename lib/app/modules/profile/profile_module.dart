import 'package:techfrenetic/app/common/custom_transitions.dart';
import 'package:techfrenetic/app/modules/profile/my_profile/my_profile_page.dart';
import 'package:techfrenetic/app/providers/followers_provider.dart';
import 'my_account/my_account_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/profile/my_activity/my_activity_page.dart';
import 'package:techfrenetic/app/modules/profile/my_content/my_content_page.dart';
import 'package:techfrenetic/app/modules/profile/profile_page.dart';
import 'package:techfrenetic/app/modules/profile/profile_store.dart';
import 'package:techfrenetic/app/modules/profile/saved_articles/my_saved_articles_page.dart';

class ProfileModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ProfileStore()),
    Bind.lazySingleton((i) => FollowersProvider())
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const ProfilePage(),
      children: [
        ChildRoute(
          '/profile',
          child: (context, args) =>
              MyProfilePage(userId: args.params['userId']),
          transition: TransitionType.custom,
          customTransition: scaleAndFadeTransition,
        ),
        ChildRoute(
          '/content',
          child: (context, args) => const MyContentPage(),
          transition: TransitionType.custom,
          customTransition: scaleAndFadeTransition,
        ),
        ChildRoute(
          '/activity',
          child: (context, args) => const MyActivityPage(),
          transition: TransitionType.custom,
          customTransition: scaleAndFadeTransition,
        ),
        ChildRoute(
          '/saved-articles',
          child: (context, args) => const MySavedArticlesPage(),
          transition: TransitionType.custom,
          customTransition: scaleAndFadeTransition,
        ),
        ModuleRoute(
          '/my-account',
          module: MyAccountModule(),
        ),
      ],
    ),
  ];
}
