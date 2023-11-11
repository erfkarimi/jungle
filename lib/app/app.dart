import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jungle/routes/routes.dart';
import 'package:jungle/view_model/app_ui_style/app_ui_style.dart';
import '../constant/palette/palette.dart';
import 'package:get/get.dart';

class App extends StatefulWidget{
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final Box settingsBox = Hive.box("settings");
  
  @override 
  Widget build(context){
    return ValueListenableBuilder(
      valueListenable: settingsBox.listenable(),
      builder: (context, settingsBox, _) {
        return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                theme: themeData(settingsBox),
              routes: appRoutes,
              initialRoute: "/splashScreen",
        );
      }
    );
  }

  ThemeData themeData(Box box){
    final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context);
    appUiStyle.darkTheme = box.get("darkTheme");
    return ThemeData(
                primarySwatch: Palette.ultramarineBlue,
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(seedColor: Palette.ultramarineBlue),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Palette.ultramarineBlue),
                fontFamily: "Regular",
                pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android : CupertinoPageTransitionsBuilder()
                },
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: appUiStyle.setBackgroundTheme(),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light,
                  systemNavigationBarColor: appUiStyle.setBackgroundTheme(),
                  systemNavigationBarIconBrightness: Brightness.light,
                  statusBarColor: Colors.transparent,
                )
              ),
              scaffoldBackgroundColor: appUiStyle.setBackgroundTheme(),
              );
  }
}