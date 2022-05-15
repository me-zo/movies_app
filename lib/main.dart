import 'dart:io';

import 'package:flutter/material.dart';

import 'app/app.dart';
import 'core/dependency_registrar/dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Dependencies.init();

  //TODO: REMOVE IN PRODUCTION (for overriding http certificates)
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

// TODO: REMOVE IN PRODUCTION (for overriding http certificates)
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
