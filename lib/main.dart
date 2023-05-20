import 'dart:io';

import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/configuration.dart';
import 'core/dependency_registrar/dependencies.dart';
import 'core/utils/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies(_extractBuildFromDartDefinedVariable());

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

Build _extractBuildFromDartDefinedVariable() {
  //throws an exception if not found (We need the app to error on launch so we avoid build environment confusion)
  var build = Build.values
      .byName(const String.fromEnvironment("Build", defaultValue: "DEVELOP"));
  Log.d("A ${build.name} Build is starting up...");
  return build;
}
