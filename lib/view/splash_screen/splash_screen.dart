import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
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
    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xff009688),
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: Material(
        color: Color(0xff009688),
        child: Center(
          child: Text(
            "Jungle",
            style: TextStyle(
              color: Colors.white,
              fontSize: 45,
              fontWeight: FontWeight.bold

            ),
          )
        )
      ),
    );
  }

  void navigation(){
    Timer(
      const Duration(seconds: 1), (){
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