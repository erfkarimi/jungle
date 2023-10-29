import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SecondWelcomePage extends StatelessWidget {
  const SecondWelcomePage({super.key});
  @override
  Widget build(context) {
    return Scaffold(
        backgroundColor: Colors.teal,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "asset/image/notes-pana.png",
                  width: 300,
                ),
                const Text(
"""Jungle helps you
to save and manage
your tasks and todos.""",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      wordSpacing: 5,
                    )),
                // const Expanded(child: SizedBox()),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     backButtonWidget(),
                //     pageBarWidget(),
                //     nextButtonWidget()
                //   ],
                // )
              ],
            ),
          ),
        ));
  }

  Widget backButtonWidget() {
    return TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text(
          "Back",
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold
            ),
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
      ],
    );
  }

  Widget nextButtonWidget() {
    return TextButton(
        onPressed: () {
          Get.toNamed("/thirdWelcome");
        },
        child: const Text(
          "Next",
          style: TextStyle(
            color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.bold
          ),
        ));
  }
}
