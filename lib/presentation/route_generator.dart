import 'package:flutter/material.dart';

import 'home/presentation/home_page.dart';

class RouteGenerator {
  Route? call(RouteSettings routeSettings) {
    return MaterialPageRoute<void>(
      settings: routeSettings,
      builder: (BuildContext context) {
        switch (routeSettings.name) {
          default:
            return const HomePage();
        }
      },
    );
  }
}
