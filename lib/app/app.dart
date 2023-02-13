import 'package:flutter/material.dart';
import 'package:jungle/view/splash_screen/splash_screen.dart';
import '../model/palette/palette.dart';

class App extends StatelessWidget{
  const App({super.key});

  @override 
  Widget build(context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Palette.copenhagenBlue,
        fontFamily: "Lato"
      ),
      home: const SplashScreen(),
    );
  }
}