import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:jungle/constant/constant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constant/palette/palette.dart';
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
            children: [
              PageWidget(
              text: text1,
              image: "asset/image/1st_page.png",
              backgroundColor: Colors.purple.shade800
              ),
              PageWidget(
              text: text2,
              image: "asset/image/2nd_page.png",
              backgroundColor: Colors.teal
              ),
              PageWidget(
              text: text3,
              image: "asset/image/3rd_page.png",
              backgroundColor: Palette.ultramarineBlue)
            ],
          ),
          
        bottomNavigationBar: pageSwitcherWidget(),
      ),
    );
  }

  Widget pageSwitcherWidget(){
    return Container(
          height: 50,
          color: const Color(0xff29c5e6),
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
                    const Color(0xff29c5e6) 
                    :Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
              );
  }
}