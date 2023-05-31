import 'package:techfrenetic/app/modules/articles/articles_store.dart';
import 'package:techfrenetic/app/modules/chat/chat_module.dart';
import 'package:techfrenetic/app/modules/courses/courses_module.dart';
import 'package:techfrenetic/app/modules/profile/my_profile/followers/followers_page.dart';
import 'package:techfrenetic/app/providers/followers_provider.dart';

import '../courses/course_page.dart';
import '../courses/lesson_page.dart';
import 'home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/core/auth_guard.dart';
import 'package:techfrenetic/app/core/onboarding_guard.dart';
import 'package:techfrenetic/app/modules/about_us/about_us_page.dart';
import 'package:techfrenetic/app/modules/articles/articles_module.dart';
import 'package:techfrenetic/app/modules/choose_avatar/choose_avatar_module.dart';
import 'package:techfrenetic/app/modules/community/community_module.dart';
import 'package:techfrenetic/app/modules/contact_us/contact_us_module.dart';
import 'package:techfrenetic/app/modules/create_groups/create_groups_module.dart';
import 'package:techfrenetic/app/modules/edit_avatar/edit_avatar_page.dart';
import 'package:techfrenetic/app/modules/events/events_page.dart';
import 'package:techfrenetic/app/modules/forgot_password/forgot_password_module.dart';
import 'package:techfrenetic/app/modules/groups/groups_module.dart';
import 'package:techfrenetic/app/modules/home/home_store.dart';
import 'package:techfrenetic/app/modules/login/login_module.dart';
import 'package:techfrenetic/app/modules/meetups/meetups_module.dart';
import 'package:techfrenetic/app/modules/not_implemented/not_implemented_page.dart';
import 'package:techfrenetic/app/modules/notifications/notifications_module.dart';
import 'package:techfrenetic/app/modules/privacy_policy/privacy_poicy_page.dart';
import 'package:techfrenetic/app/modules/profile/profile_module.dart';
import 'package:techfrenetic/app/modules/profile/profile_store.dart';
import 'package:techfrenetic/app/modules/search/search_module.dart';
import 'package:techfrenetic/app/modules/sign_up/create_profile/create_profile_module.dart';
import 'package:techfrenetic/app/modules/sign_up/sign_up_module.dart';
import 'package:techfrenetic/app/modules/stories/stories_view_page.dart';
import 'package:techfrenetic/app/modules/terms/terms_page.dart';
import 'package:techfrenetic/app/modules/users_profiles/user_profile_module.dart';
import 'package:techfrenetic/app/modules/vendors_search/vendors_search_page.dart';
import 'package:techfrenetic/app/modules/vendors/vendors_page.dart';
import 'package:techfrenetic/app/modules/videos/videos_module.dart';
import 'package:techfrenetic/app/modules/welcome/welcome_page.dart';
import 'package:techfrenetic/app/providers/user_provider.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
    Bind.lazySingleton((i) => ArticlesStore()),
    Bind.lazySingleton((i) => UserProvider()),
    Bind.lazySingleton((i) => ProfileStore()),
    Bind.lazySingleton((i) => FollowersProvider()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const HomePage(),
      children: [
        ModuleRoute('/community/', module: CommunityModule()),
        ModuleRoute(
          '/courses',
          module: CoursesModule(),
          guards: [
            AuthGuard(),
          ],
        ),
        ChildRoute('/vendors', child: (context, args) => const VendorsPage()),
        ModuleRoute('/profile', module: ProfileModule()),
      ],
      guards: [
        AuthGuard(),
        OnboardingGuard(),
      ],
    ),
    ChildRoute('/events', child: (context, args) => const EventsPage()),
    ChildRoute(
      '/vendors_search',
      child: (context, args) => const VendorsSearchPage(),
    ),
    ModuleRoute(
      '/groups/',
      module: GroupsModule(),
      guards: [
        AuthGuard(),
      ],
    ),
    ChildRoute(
      '/about_us',
      child: (context, args) => const AboutUsPage(),
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
      '/users_profiles',
      module: UsersProfilesModule(),
      guards: [
        AuthGuard(),
      ],
    ),
    ModuleRoute(
      '/contact_us',
      module: ContactUsModule(),
      guards: [
        AuthGuard(),
      ],
    ),
    ModuleRoute(
      '/create_meetups',
      module: MeetupsModule(),
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
    ChildRoute(
      "/courses/:id",
      child: (_, args) => CoursePage(id: int.parse(args.params["id"])),
    ),
    ChildRoute(
      "/courses/lesson",
      child: (context, args) => LessonPage(
        title: args.data["title"],
        video: args.data["video"],
        description: args.data["description"],
      ),
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
      '/search',
      module: SearchModule(),
      guards: [
        AuthGuard(),
      ],
    ),
    ModuleRoute(
      '/notifications',
      module: NotificationsModule(),
      guards: [
        AuthGuard(),
      ],
    ),
    ModuleRoute(
      '/create_profile',
      module: CreateProfileModule(),
    ),
    ModuleRoute(
      '/choose_avatar',
      module: ChooseAvatarModule(),
    ),
    ChildRoute(
      '/edit_avatar',
      child: (context, args) => EditAvatarPage(),
      guards: [
        AuthGuard(),
      ],
    ),
    ModuleRoute(
      '/forgot',
      module: ForgotPasswordModule(),
    ),
    ModuleRoute(
      '/chat',
      module: ChatModule(),
    ),
    ChildRoute(
      "/stories",
      child: (context, args) => StoriesViewPage(video: args.data),
      guards: [
        AuthGuard(),
      ],
    ),
    ChildRoute(
      '/not_implemented',
      child: (context, args) => const NotImplementedPage(),
    ),
    ChildRoute(
      '/following',
      child: (context, args) => FollowersPage(
        followers: args.data['followers'],
        following: args.data['following'],
      ),
      guards: [
        AuthGuard(),
      ],
    )
  ];
}
