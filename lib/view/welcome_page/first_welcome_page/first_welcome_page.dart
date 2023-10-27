import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class FirstWelcomePage extends StatelessWidget {
  const FirstWelcomePage({super.key});

  @override
  Widget build(context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.purple.shade800,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ),
      child: Scaffold(
          backgroundColor: Colors.purple.shade800,
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24, vertical: 10
            ),
            child: Column(
              children: [
                const Expanded(child: SizedBox()),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Welcome !!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                Image.asset(
                  "asset/image/notes-amico.png",
                  width: 300,
                ),
                const Text(
"""Thanks for choosing
Jungle. We hope you
enjoy it and go to
next pages for more
about us.""",   
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      wordSpacing: 5,
                    )),
                const Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    skipButtonWidget(),
                    pageBarWidget(),
                    nextButtonWidget()
                    
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget skipButtonWidget(){
    final welcomePageDB = Hive.box("welcome");
    return TextButton(
        onPressed: () {
          welcomePageDB.put("welcomePage", true);
          Get.offNamed("/homePage");
        },
        child: const Text(
          "Skip",
          style: TextStyle(
              color: Colors.grey, fontSize: 17, fontWeight: FontWeight.bold),
        ));
  }
  
  Widget pageBarWidget(){
      return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 6,
          width: 80,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
        ),
        const SizedBox(width: 10),
        Container(
          height: 6,
          width: 6,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
        ),
        const SizedBox(width: 10),
        Container(
          height: 6,
          width: 6,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
        ),
      ],
    );
  }

  Widget nextButtonWidget(){
    return TextButton(
        onPressed: () {
          Get.toNamed("/secondWelcome");
        },
        child: const Text(
          "Next",
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
        ));
  }
}
