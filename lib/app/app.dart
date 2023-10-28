import 'package:flutter/material.dart';
import 'package:jungle/routes/routes.dart';
import 'package:jungle/view_model/set_theme/set_theme.dart';
import 'package:provider/provider.dart';
import '../model/palette/palette.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends GetMaterialApp{
  const App({super.key});

  @override 
  Widget build(context){
    return Consumer<SetTheme>(
      builder: (context, setTheme, _) {
        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
            primarySwatch: Palette.ultramarineBlue,
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Palette.ultramarineBlue),
            textTheme: GoogleFonts.latoTextTheme(),
            appBarTheme: AppBarTheme(
              backgroundColor: setTheme.setAppBarTheme()
            ),
            scaffoldBackgroundColor: setTheme.setAppBarTheme(),
            bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: setTheme.setBackgroundTheme()
            ),
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
    );
  }
}