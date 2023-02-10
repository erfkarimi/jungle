import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import '../page_3/page_3.dart';

class Page2 extends StatelessWidget{
  const Page2({super.key});

  @override 
  Widget build(context){
    setTheme();
    return Material(
      color: Colors.teal,
      child: Padding(
        padding: const EdgeInsets.all(24),
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
You can save your
tasks, notes and
share them with
your friends.
""",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
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
                const SizedBox(width: 66),
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
                const SizedBox(width: 66),
                MaterialButton(
                minWidth: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                onPressed: (){
                  
                  Navigator.of(context).push(
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const Page3()
                    )
                  );
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
        ),
      ),
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