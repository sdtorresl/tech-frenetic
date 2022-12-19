import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:global_configuration/global_configuration.dart';
import 'dart:io';
import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'app/core/user_preferences.dart';

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

  final prefs = UserPreferences();
  await prefs.initPrefs();

  await GlobalConfiguration().loadFromPath("assets/cfg/app_settings.json");
  await Firebase.initializeApp();
  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
