import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jungle/view/home/home_page.dart';
import 'package:jungle/view/onboarding_page/onboarding_page.dart';

class Wrapper extends StatelessWidget{
  const Wrapper({super.key});

  @override 
  Widget build(context){
    final Box settingsBox = Hive.box("settings");
    return ValueListenableBuilder(
          valueListenable: settingsBox.listenable(),
          builder: (context, box, child){
            return settingsBox.get("introduction", defaultValue: false) 
            ? const HomePage() : const OnboardingPage();
          }
        );
  }
}