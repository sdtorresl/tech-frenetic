import 'package:techfrenetic/app/modules/sign_up/create_profile/confirm_number_page.dart';
import 'package:techfrenetic/app/providers/countries_provider.dart';
import 'package:techfrenetic/app/providers/genres_provider.dart';
import 'package:techfrenetic/app/providers/professions_provider.dart';

import 'create_profile_controller.dart';
import 'create_profile_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CreateProfileModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CreateProfileController()),
    Bind.lazySingleton((i) => CountriesProvider()),
    Bind.lazySingleton((i) => ProfessionsProvider()),
    Bind.lazySingleton((i) => GenresProvider()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => const CreateProfilePage()),
    ChildRoute('/confirm_number',
        child: (_, args) => const ConfirmNumberPage()),
  ];
}
