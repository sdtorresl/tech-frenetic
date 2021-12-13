import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/contact_us/contact_us_controller.dart';
import 'package:techfrenetic/app/modules/contact_us/contact_us_page.dart';

class ContactUsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ContactUsController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const ContactUsPage(),
    ),
  ];
}
