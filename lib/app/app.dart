import 'package:flutter/material.dart';
import 'package:jungle/routes/routes.dart';
import 'package:jungle/view_model/app_ui_style/app_ui_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/palette/palette.dart';
import 'package:get/get.dart';
import '../view_model/db_counter_state/db_counter_state.dart';

class App extends StatefulWidget{
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    appInitState(context);
    super.initState();
  }
  @override 
  Widget build(context){
    return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
            primarySwatch: Palette.ultramarineBlue,
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Palette.ultramarineBlue),
            fontFamily: "Regular",
            pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android : CupertinoPageTransitionsBuilder()
            },
          ),
          ),
          routes: appRoutes,
          initialRoute: "/splashScreen",
    );
  }
  Future<void> appInitState(context) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context, listen: false);
    final DbCounterState dbCounterState = Provider.of<DbCounterState>(context, listen: false);

      appUiStyle.theme = preferences.getString("Theme") ?? "Light";
      appUiStyle.font = preferences.getString("Font") ?? "Regular";
      dbCounterState.taskCounter = preferences.getInt("taskCounter") ?? 0;
      dbCounterState.todoCounter = preferences.getInt("todoCounter") ?? 0;
      dbCounterState.completedCounter = preferences.getInt("completedCounter") ?? 0;
  }
}