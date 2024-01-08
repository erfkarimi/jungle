import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jungle/routes/routes.dart';
import 'package:get/get.dart';

import '../theme/theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
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
            initialRoute: "/splashScreen",
          );
        });
  }
}