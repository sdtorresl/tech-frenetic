import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:global_configuration/global_configuration.dart';
import 'dart:io';
import 'app/app_module.dart';
import 'app/app_widget.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  await GlobalConfiguration().loadFromPath("assets/cfg/app_settings.json");
  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
