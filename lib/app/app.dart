import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jungle/l10n/l10n.dart';
import 'package:jungle/view/splash_screen/splash_screen.dart';
import '../model/palette/palette.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends MaterialApp{
  App({super.key})
  : super(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primarySwatch: Palette.copenhagenBlue,
        fontFamily: "Lato"
      ),
      supportedLocales: L10n.all,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      home: const SplashScreen(),
  );
}