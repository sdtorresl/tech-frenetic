import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:global_configuration/global_configuration.dart';
import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() async {
  await GlobalConfiguration().loadFromAsset("app_settings");
  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
