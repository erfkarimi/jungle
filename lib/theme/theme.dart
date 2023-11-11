import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/palette/palette.dart';
import '../view_model/app_ui_style/app_ui_style.dart';

ThemeData themeData(BuildContext context, Box box) {
  final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context);
  appUiStyle.darkTheme = box.get("darkTheme", defaultValue: false);
  return ThemeData(
      primarySwatch: Palette.ultramarineBlue,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Palette.ultramarineBlue),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Palette.ultramarineBlue),
      fontFamily: "Regular",
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder()},
      ),
      //---- AppBar theming section ----
      appBarTheme: AppBarTheme(
          backgroundColor: appUiStyle.setBackgroundTheme(),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: appUiStyle.setBackgroundTheme(),
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarColor: Colors.transparent,
          ),
          titleTextStyle:
              TextStyle(color: appUiStyle.setTextTheme(), fontSize: 20)),
      //---- TabBar theming section ----
      tabBarTheme: TabBarTheme(
        dividerColor: appUiStyle.setBackgroundTheme(),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.blue.shade600,
        labelColor: Colors.blue.shade600,
        unselectedLabelColor: appUiStyle.setDescriptionTheme(),
      ),
      scaffoldBackgroundColor: appUiStyle.setBackgroundTheme(),
      textTheme: GoogleFonts.latoTextTheme()
          .apply(bodyColor: appUiStyle.setTextTheme()),
      //---- Dialog theming section ----
      dialogBackgroundColor: appUiStyle.setBackgroundTheme(),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      //---- ListTile theming section ----
      listTileTheme: ListTileThemeData(
          titleTextStyle: TextStyle(color: appUiStyle.setTextTheme()),
          subtitleTextStyle:
              TextStyle(color: appUiStyle.setDescriptionTheme())),
      cardTheme: CardTheme(color: appUiStyle.setItemBackgroundTheme()),
      iconTheme: IconThemeData(
        color: appUiStyle.setTextTheme(),
      ));
}
