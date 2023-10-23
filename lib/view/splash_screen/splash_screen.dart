import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jungle/model/palette/palette.dart';
import 'package:jungle/view/home/home.dart';
import 'package:jungle/view/welcome_page/welcome_page.dart';
import 'package:jungle/view_model/set_theme/set_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'dart:async';

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
    init(context);
    setTheme();
  }

  @override 
  Widget build(context){
    return Material(
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
    );
  }

  void navigation(){
    Timer(
      const Duration(seconds: 2), (){
        Get.off(()=> ValueListenableBuilder(
          valueListenable: welcomePageDB.listenable(),
          builder: (context, box, child){
            return welcomePageDB.get("welcomePage", defaultValue: false) 
            ? const Home() : const WelcomePage();
          }
        ),
          );
      }
      );
  }

  Future<void> init(context) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final setTheme = Provider.of<SetTheme>(context, listen: false);
    setState(() {
      setTheme.theme = preferences.getString("theme") ?? "light";
    });
  }

  void setTheme(){
    setState(() {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Palette.ultramarineBlue,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ));     
    });
  }
}