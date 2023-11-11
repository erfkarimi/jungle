import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jungle/constant/palette/palette.dart';
import 'package:jungle/view/home/home_page.dart';
import 'package:jungle/view/onboarding_page/onboarding_page.dart';
import 'package:get/get.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override 
  SplashScreenState createState()=> SplashScreenState();
} 

class SplashScreenState extends State<SplashScreen>{

  final Box settingsBox = Hive.box("settings");

  @override 
  void initState() {
    super.initState();
    navigation();
  }

  @override 
  Widget build(context){
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Palette.ultramarineBlue,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: Material(
        color: Palette.ultramarineBlue,
        child: const Center(
          child: Text(
            "Jungle",
            style: TextStyle(
              color: Colors.white,
              fontSize: 45,
            ),
          )
        )
      ),
    );
  }

  void navigation(){
    Timer(
      const Duration(seconds: 2), (){
        Get.off(()=> ValueListenableBuilder(
          valueListenable: settingsBox.listenable(),
          builder: (context, box, child){
            return settingsBox.get("introduction", defaultValue: false) 
            ? const HomePage() : const OnboardingPage();
          }
        ),
          );
      }
      );
  }
  }