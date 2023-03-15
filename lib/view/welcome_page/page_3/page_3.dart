import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:jungle/view/home/home.dart';
import 'package:page_transition/page_transition.dart';
import '../page_2/page_2.dart';

class Page3 extends StatelessWidget{
  const Page3({super.key});

  @override 
  Widget build(context){
    final welcomePageDB = Hive.box("welcomePage");
    setTheme();
    return Material(
      color: Colors.blue.shade700,
      child: Padding(
        padding: const EdgeInsets.all(24),
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
So let's start using
Jungle I hope you 
enjoy it.
""",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              wordSpacing: 5,
              letterSpacing: 2
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
                   Navigator.of(context).pop(
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const Page2()
                    )
                  );
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
                   Navigator.of(context).pushReplacement(
                    PageTransition(
                      child: const Home(),
                      type: PageTransitionType.rightToLeft
                    )
                   );
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
        ),
      ),
    );
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