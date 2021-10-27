import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:global_configuration/global_configuration.dart';
import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromPath("assets/cfg/app_settings.json");
  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
