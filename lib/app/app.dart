import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movies_app/presentation/actions/actions_view_model.dart';
import 'package:movies_app/presentation/home/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../presentation/home/screens/splash.dart';
import '../presentation/settings_view_model.dart';
import '../app/localization/resources.dart';
import '../core/dependency_registrar/dependencies.dart';
import '../presentation/route_generator.dart';

/// The Widget that configures your application.
class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsNotifier>(
      create: (_) => getIt<SettingsNotifier>(),
      child: Consumer<SettingsNotifier>(
        builder: (context, settings, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<HomeViewModel>(
                create: (context) => HomeViewModel(),
              ),
              ChangeNotifierProvider<ActionsViewModel>(
                create: (context) => ActionsViewModel(),
              ),
            ],
            child: MaterialApp(
              builder: (context, widget) => ResponsiveWrapper.builder(
                ClampingScrollWrapper.builder(context, widget!),
                breakpoints: const [
                  ResponsiveBreakpoint.resize(400,
                      name: MOBILE, scaleFactor: 1),
                  ResponsiveBreakpoint.resize(800,
                      name: TABLET, scaleFactor: 1.4),
                ],
              ),
              debugShowCheckedModeBanner: false,
              restorationScopeId: 'app',
              localizationsDelegates: const [
                Resources.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale("en"),
                Locale("ar"),
              ],
              localeResolutionCallback: (locale, supportedLocales) {
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale!.languageCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
              locale: settings.getLocale,
              theme: settings.getTheme,
              darkTheme: settings.getTheme,
              onGenerateRoute: RouteGenerator(),
              home: const Splash(),
            ),
          );
        },
      ),
    );
  }
}
