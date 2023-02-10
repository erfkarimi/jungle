import 'package:flutter/material.dart';
import 'package:jungle/view/welcome_page/page_1/page_1.dart';

class WelcomePage extends StatelessWidget{
  const WelcomePage({super.key});

  @override 
  Widget build(context){
    return buildBody();
  }

  /* Widgets and Functions */
  Widget buildBody(){
    return const Page1();
  }
}