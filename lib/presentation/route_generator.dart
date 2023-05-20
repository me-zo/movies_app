import 'package:flutter/material.dart';

import 'home/screens/home.dart';

class RouteGenerator {
  Route? call(RouteSettings routeSettings) {
    return FadePageRoute<void>(
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

class FadePageRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;
  final String? name;
  final Object? arguments;

  FadePageRoute(
      {required this.builder,
      this.name,
      this.arguments,
      RouteSettings? settings})
      : super(settings: settings);

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 250);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
