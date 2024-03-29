import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:jungle/constant/constant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../widget/page_widget.dart/page_widget.dart';

class OnboardingPage extends StatefulWidget{
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController controller = PageController();
  final Box settingsBox = Hive.box("settings");
  bool isLastPage = false; 
  @override 
  Widget build(context){
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color(0xff009688)
      ),
      child: Scaffold(
        body: PageView(
          onPageChanged: (index){
            setState(() {
              isLastPage = index == 2;
            });
          },
          controller: controller,
            children: [
              PageWidget(
              text: text1,
              textColor: Colors.black,
              image: "asset/image/1st_page.png",
              backgroundColor: const Color(0xff7fdeff),
              statusBarIconBrightness: Brightness.dark,
              ),
              PageWidget(
              text: text2,
              textColor: Colors.white,
              image: "asset/image/2nd_page.png",
              backgroundColor: Colors.teal,
              statusBarIconBrightness: Brightness.light,
              ),
              PageWidget(
              text: text3,
              textColor: Colors.white,
              image: "asset/image/3rd_page.png",
              backgroundColor: const Color(0xff061826),
              statusBarIconBrightness: Brightness.light,)
            ],
          ),
          
        bottomNavigationBar: pageSwitcherWidget(),
      ),
    );
  }

  Widget pageSwitcherWidget(){
    return Container(
          height: 50,
          color: const Color(0xff009688),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              skipButtonWidget(),
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
                  ()=> settingsBox.put("introduction", true)
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

  Widget skipButtonWidget(){
    return TextButton(
                onPressed: isLastPage ? null : ()=> controller.jumpToPage(2),
                child: Text(
                  "Skip",
                  style: TextStyle(
                    color: isLastPage ? 
                    const Color(0xff009688) 
                    :Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
              );
  }
}