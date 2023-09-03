import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class Page3 extends StatelessWidget{
  const Page3({super.key});
  @override 
  Widget build(context){
    final welcomePageDB = Hive.box("welcome");
    setTheme();
    const String emoji = "🤞🏻";
    return Material(
      color: Colors.blue.shade700,
      child: Column(
        children: [
          const SizedBox(height: 100),
          const  SizedBox(height: 60),
          Image.asset(
            "asset/image/notes-rafiki.png",
            width: 300,
          ),
          const Text(
            """
So let's start our
journey by saving a task
and a todo$emoji
""",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            wordSpacing: 5,
          )
          ),
          const Expanded(
            child: SizedBox(height: double.infinity),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
              minWidth: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              onPressed: (){
                Get.back();
              },
              child: const Text(
                "Back",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17
                ),
              )
              ),
              const SizedBox(width: 52),
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 6,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
              const SizedBox(width: 52),
              MaterialButton(
              minWidth: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              onPressed: (){
                welcomePageDB.put("welcomePage", true);
                Get.offNamed("/home");
              },
              child: const Text(
                "Start",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17
                ),
              )
              ),
            ],
          )
        ],
      )
    ).paddingAll(24);
  }

  void setTheme(){
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.blue.shade700,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ));     
  
  }
}