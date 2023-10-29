import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jungle/constant/constant.dart';
import 'package:jungle/model/palette/palette.dart';

class ThirdWelcomePage extends StatelessWidget{
  const ThirdWelcomePage({super.key});

  @override 
  Widget build(context){
    return Scaffold(
      backgroundColor: Palette.ultramarineBlue,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24, vertical: 10
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
              "asset/image/notes-rafiki.png",
              width: 300,
            ),
              const Text(
        """ So let's start our
        journey by saving a task
        and a todo$wishLuckEmoji""",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              wordSpacing: 5,
            )
            ),
            // const Expanded(child: SizedBox()),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     backButtonWidget(),
            //     pageBarWidget(),
            //     startButtonWidget(context)
            //   ],
            // )
            ],
          ),
        ),
      ),
    );
  }

    Widget backButtonWidget() {
    return TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text(
          "Back",
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
        ));
  }

  Widget pageBarWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
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
        const SizedBox(width: 10),
        Container(
          height: 6,
          width: 80,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
        ),
      ],
    );
  }

  Widget startButtonWidget(BuildContext context) {
    final welcomePageDB = Hive.box("welcome");
    return TextButton(
        onPressed: () {
          welcomePageDB.put("welcomePage", true);
          Get.offNamed("/homePage");
        },
        child: const Text(
          "Start",
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
        ));
  }
}