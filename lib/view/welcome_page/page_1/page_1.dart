import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jungle/extension/widget_padding_x.dart';
import 'package:page_transition/page_transition.dart';
import '../page_2/page_2.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(context) {
    setTheme();
    const String hiEmoji = "👋🏻";
    return Material(
        color: Colors.purple.shade800,
        child: Column(
          children: [
            const SizedBox(height: 100),
            const Row(
              children: [
                Text(
                  "Welcome$hiEmoji",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            Image.asset(
              "asset/image/notes-amico.png",
              width: 300,
            ),
            const Text("""
Thanks for choosing
Jungle. We hope you
enjoy it and go to
next pages for more
about us.
""",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  wordSpacing: 5,
                )),
            const Expanded(
              child: SizedBox(height: double.infinity),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 6,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 6,
                  width: 6,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 6,
                  width: 6,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                ),
                const SizedBox(width: 52),
                MaterialButton(
                    minWidth: 20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.of(context).push(PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const Page2()));
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )),
              ],
            )
          ],
        ).paddingAll(24));
  }

  void setTheme() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.purple.shade800,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ));
  }
}
