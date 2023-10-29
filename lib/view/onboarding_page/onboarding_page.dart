import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jungle/view/welcome_page/first_welcome_page/first_welcome_page.dart';
import 'package:jungle/view/welcome_page/second_welcome_page/second_welcome_page.dart';
import 'package:jungle/view/welcome_page/third_welcome_page/third_welcome_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget{
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController controller = PageController();
  bool isLastPage = false; 
  @override 
  Widget build(context){
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xff29c5e6)
      ),
      child: Scaffold(
        body: PageView(
          onPageChanged: (index){
            setState(() {
              isLastPage = index == 2;
            });
          },
          controller: controller,
            children: const [
              FirstWelcomePage(),
              SecondWelcomePage(),
              ThirdWelcomePage()
            ],
          ),
          
        bottomNavigationBar: pageSwitcherWidget(),
      ),
    );
  }

  Widget pageSwitcherWidget(){
    final Box welcomePageDB = Hive.box("welcome");
    return Container(
          height: 50,
          color: const Color(0xff29c5e6),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: ()=> controller.jumpToPage(2),
                child: const Text(
                  "Skip",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Center(
                child: SmoothPageIndicator(
                  count: 3,
                  controller: controller,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.white,
                    dotHeight: 10,
                    dotWidth: 10,
                    activeDotColor: Colors.white
                  ),
                  onDotClicked: (index){
                    controller.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                  },
                ),
              ),
              TextButton(
                onPressed: isLastPage ? 
                  ()=> welcomePageDB.put("welcomePage", true)
                  : (){
                  controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
                },
                child: isLastPage  ? 
                const Text(
                  "Start",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ) : const Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                )
              )
            ],
          ),
        );
  }
}