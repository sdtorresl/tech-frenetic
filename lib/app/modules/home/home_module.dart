import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/articles/articles_module.dart';
import 'package:techfrenetic/app/modules/community/community_module.dart';
import 'package:techfrenetic/app/modules/forgot_password/forgot_password_module.dart';
import 'package:techfrenetic/app/modules/login/login_module.dart';
import 'package:techfrenetic/app/modules/privacy_policy/privacy_poicy_page.dart';
import 'package:techfrenetic/app/modules/profile/profile_page.dart';
import 'package:techfrenetic/app/modules/create_profile/create_profile_module.dart';
import 'package:techfrenetic/app/modules/choose_avatar/choose_avatar_module.dart';
import 'package:techfrenetic/app/modules/welcome/welcome_page.dart';
import 'package:techfrenetic/app/modules/sign_up/sign_up_module.dart';
import 'package:techfrenetic/app/modules/events/events_page.dart';
import 'package:techfrenetic/app/modules/vendors/vendors_page.dart';
import 'package:techfrenetic/app/modules/videos/videos_module.dart';

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
          child: (context, args) => const VendorsPage(),
        ),
        ChildRoute(
          '/profile',
          child: (context, args) => const ProfilePage(),
        ),
        ChildRoute(
          '/choose_avatar/welcome',
          child: (context, args) => const WelcomePage(),
        ),
      ],
    ),
    ChildRoute(
      '/welcome',
      child: (context, args) => const WelcomePage(),
    ),
    ChildRoute(
      '/privacy_policy',
      child: (context, args) => const PrivacyPolicyPage(),
    ),
    ModuleRoute('/community/article', module: ArticlesModule()),
    ModuleRoute('/community/video', module: VideosModule()),
    ModuleRoute('/login', module: LoginModule()),
    ModuleRoute('/sign', module: SignUpModule()),
    ModuleRoute('/create_profile', module: CreateProfileModule()),
    ModuleRoute('/choose_avatar', module: ChooseAvatarModule()),
    ModuleRoute('/forgot', module: ForgotPasswordModule()),
  ];
}
