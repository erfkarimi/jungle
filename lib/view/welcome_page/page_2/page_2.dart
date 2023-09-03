import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Page2 extends StatelessWidget{
  const Page2({super.key});

  @override 
  Widget build(context){
    setTheme();
    return Material(
      color: Colors.teal,
      child: Column(
        children: [
          const SizedBox(height: 100),
          const  SizedBox(height: 60),
          Image.asset(
            "asset/image/notes-pana.png",
            width: 300,
          ),
          const Text(
            """
Jungle helps you
to save and manage
your tasks and todos.
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
                width: 80,
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
              const SizedBox(width: 52),
              MaterialButton(
              minWidth: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              onPressed: (){
                Get.toNamed("/page3");
              },
              child: const Text(
                "Next",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17
                ),
              )
              ),
            ],
          )
        ],
      ).paddingAll(24),
    );
  }


  void setTheme(){
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.teal,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ));     
  
  }
}