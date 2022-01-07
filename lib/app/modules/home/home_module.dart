import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/core/auth_guard.dart';
import 'package:techfrenetic/app/modules/articles/articles_module.dart';
import 'package:techfrenetic/app/modules/community/community_module.dart';
import 'package:techfrenetic/app/modules/contact_us/contact_us_module.dart';
import 'package:techfrenetic/app/modules/create_groups/create_groups_module.dart';
import 'package:techfrenetic/app/modules/create_groups/create_groups_page.dart';
import 'package:techfrenetic/app/modules/create_meetups/create_meetups_module.dart';
import 'package:techfrenetic/app/modules/forgot_password/forgot_password_module.dart';
import 'package:techfrenetic/app/modules/groups/groups_module.dart';
import 'package:techfrenetic/app/modules/profile/profile_module.dart';
import 'package:techfrenetic/app/providers/user_provider.dart';
import 'package:techfrenetic/app/widgets/about_us_widget.dart';
import 'package:techfrenetic/app/modules/login/login_module.dart';
import 'package:techfrenetic/app/modules/privacy_policy/privacy_poicy_page.dart';
import 'package:techfrenetic/app/modules/create_profile/create_profile_module.dart';
import 'package:techfrenetic/app/modules/choose_avatar/choose_avatar_module.dart';
import 'package:techfrenetic/app/modules/vendors_search/vendors_search_page.dart';
import 'package:techfrenetic/app/modules/terms/terms_page.dart';
import 'package:techfrenetic/app/modules/skills/skills_page.dart';
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
    Bind.lazySingleton((i) => UserProvider()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const HomePage(),
      children: [
        ModuleRoute('/community/', module: CommunityModule()),
        ModuleRoute('/contact_us', module: ContactUsModule()),
        ModuleRoute('/groups', module: GroupsModule()),
        ChildRoute(
          '/skills',
          child: (context, args) => const SkillsPage(),
        ),
        ChildRoute(
          '/vendors',
          child: (context, args) => const VendorsPage(),
        ),
        ChildRoute(
          '/vendors_search',
          child: (context, args) => const VendorsSearchPage(),
        ),
        ModuleRoute('/profile', module: ProfileModule()),
        ChildRoute(
          '/events',
          child: (context, args) => const EventsPage(),
        ),
      ],
      guards: [AuthGuard()],
    ),
    ChildRoute(
      '/about_us',
      child: (context, args) => const AboutUsWidget(),
      guards: [
        AuthGuard(),
      ],
    ),
    ChildRoute(
      '/welcome',
      child: (context, args) => const WelcomePage(),
      guards: [
        AuthGuard(),
      ],
    ),
    ChildRoute(
      '/privacy_policy',
      child: (context, args) => const PrivacyPolicyPage(),
      guards: [
        AuthGuard(),
      ],
    ),
    ChildRoute(
      '/terms',
      child: (context, args) => const TermsPage(),
      guards: [
        AuthGuard(),
      ],
    ),

    ModuleRoute(
      '/create_meetups',
      module: CreateMeetupsModule(),
      guards: [
        AuthGuard(),
      ],
    ),
    ModuleRoute(
      '/community/groups/create_groups',
      module: CreateGroupsModule(),
      guards: [
        AuthGuard(),
      ],
    ),
    ModuleRoute(
      '/community/article',
      module: ArticlesModule(),
      guards: [
        AuthGuard(),
      ],
    ),
    ModuleRoute(
      '/community/video',
      module: VideosModule(),
      guards: [
        AuthGuard(),
      ],
    ),
    ModuleRoute(
      '/login',
      module: LoginModule(),
    ),
    ModuleRoute(
      '/sign',
      module: SignUpModule(),
    ),
    ModuleRoute(
      '/create_profile',
      module: CreateProfileModule(),
    ),
    ModuleRoute(
      '/choose_avatar',
      module: ChooseAvatarModule(),
    ),
    ModuleRoute(
      '/forgot',
      module: ForgotPasswordModule(),
    ),
    // ModuleRoute(
    //   '/create_groups',
    //   module: CreateGroupsModule(),

    // ),
  ];
}
