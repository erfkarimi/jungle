import 'package:flutter/material.dart';
import 'package:jungle/routes/routes.dart';
import '../model/palette/palette.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends GetMaterialApp{
  App({super.key}) : super(
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