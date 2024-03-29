import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:google_fonts/google_fonts.dart';
import '../view_model/app_ui_style/app_ui_style.dart';
import "dart:io";

ThemeData themeData(BuildContext context, Box box) {
  final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context);
  appUiStyle.darkTheme = box.get("darkTheme", defaultValue: false);
  return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.teal,
        brightness: appUiStyle.darkTheme ? Brightness.dark : Brightness.light,
        ),
      fontFamily: Platform.localeName == "en" ? "Lato" : "Vazirmatn",
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder()},
      ),
      textTheme: Platform.localeName == "en" ? 
      GoogleFonts.latoTextTheme()
          .apply(bodyColor: appUiStyle.setTextTheme())
          : GoogleFonts.vazirmatnTextTheme()
          .apply(bodyColor: appUiStyle.setTextTheme()),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: appUiStyle.snackBarTheme(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0.0
      ),
      listTileTheme: ListTileThemeData(
        subtitleTextStyle: TextStyle(
          fontFamily: Platform.localeName == "en" ? "Lato" : "Vazirmatn",
          color: appUiStyle.setDescriptionTheme()
        )
      ),
  );
}