import 'package:flutter/material.dart';
import 'package:jungle/view/splash_screen/splash_screen.dart';
import '../model/palette/palette.dart';

class App extends MaterialApp{
  App({super.key})
  : super(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primarySwatch: Palette.ultramarineBlue,
        fontFamily: "Lato"
      ),
      home: const SplashScreen(),
  );
}