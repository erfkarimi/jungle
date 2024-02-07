import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jungle/l10n/l10n.dart';
import 'package:jungle/routes/routes.dart';
import 'package:get/get.dart';
import "package:flutter_localizations/flutter_localizations.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../theme/theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  final Box settingsBox = Hive.box("settings");

  @override
  Widget build(context) {
    return ValueListenableBuilder(
        valueListenable: settingsBox.listenable(),
        builder: (context, settingsBox, _) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeData(context, settingsBox),
            routes: appRoutes,
            initialRoute: "/wrapper",
            supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
          );
        });
  }
}
