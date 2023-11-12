import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:google_fonts/google_fonts.dart';
import '../view_model/app_ui_style/app_ui_style.dart';

ThemeData themeData(BuildContext context, Box box) {
  final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context);
  appUiStyle.darkTheme = box.get("darkTheme", defaultValue: false);
  return ThemeData(
      useMaterial3: true,
      brightness: appUiStyle.darkTheme ? Brightness.dark : Brightness.light,
      colorSchemeSeed: Colors.teal,
      fontFamily: "Regular",
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder()},
      ),
      textTheme: GoogleFonts.latoTextTheme()
          .apply(bodyColor: appUiStyle.setTextTheme()),
  );
}
