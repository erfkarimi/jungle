import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jungle/model/palette/palette.dart';
import 'package:jungle/view/home/home_page.dart';
import 'package:jungle/view/onboarding_page/onboarding_page.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../../view_model/app_ui_style/app_ui_style.dart';
import '../../view_model/db_counter_state/db_counter_state.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override 
  SplashScreenState createState()=> SplashScreenState();
} 

class SplashScreenState extends State<SplashScreen>{

  final Box welcomePageDB = Hive.box("welcome");

  @override 
  void initState() {
    super.initState();
    navigation();
    appInitState(context);
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
              fontSize: 45
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
          valueListenable: welcomePageDB.listenable(),
          builder: (context, box, child){
            return welcomePageDB.get("welcomePage", defaultValue: false) 
            ? const HomePage() : const OnboardingPage();
          }
        ),
          );
      }
      );
  }
  
  Future<void> appInitState(context) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context, listen: false);
    final DbCounterState dbCounterState = Provider.of<DbCounterState>(context, listen: false);

      appUiStyle.theme = preferences.getString("theme") ?? "light";
      dbCounterState.taskCounter = preferences.getInt("taskCounter") ?? 0;
      dbCounterState.todoCounter = preferences.getInt("todoCounter") ?? 0;
      dbCounterState.completedCounter = preferences.getInt("completedCounter") ?? 0;
  }
}