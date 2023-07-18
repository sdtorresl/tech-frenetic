import 'package:techfrenetic/app/modules/vendors/vendor_page.dart';
import 'package:techfrenetic/app/modules/vendors/vendors_page.dart';
import 'package:techfrenetic/app/modules/vendors/vendors_store.dart';
import 'package:techfrenetic/app/modules/vendors/vendor_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/providers/vendors_provider.dart';

class VendorsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => VendorsProvider()),
    Bind.lazySingleton((i) => VendorsStore()),
    Bind.lazySingleton((i) => VendorStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: ((context, args) => const VendorsPage()),
    ),
    ChildRoute(
      "/:id",
      child: ((context, args) => VendorPage(
            vendor: args.data,
          )),
    ),
  ];
}
