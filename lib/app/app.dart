import 'package:flutter/material.dart';
import 'package:jungle/routes/routes.dart';
import 'package:jungle/view_model/app_ui_style/app_ui_style.dart';
import 'package:provider/provider.dart';
import '../model/palette/palette.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget{
  const App({super.key});

  @override 
  Widget build(context){
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        primarySwatch: Palette.ultramarineBlue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Palette.ultramarineBlue),
        textTheme: GoogleFonts.latoTextTheme(),
        pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android : CupertinoPageTransitionsBuilder()
        }
      )
      ),
      routes: appRoutes,
      initialRoute: "/splashScreen",
    );
  }
}