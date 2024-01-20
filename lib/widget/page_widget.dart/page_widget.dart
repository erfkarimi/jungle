import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PageWidget extends StatelessWidget{
  final String text;
  final Color textColor;
  final String image;
  final Color backgroundColor;
  final Brightness statusBarIconBrightness;

  const PageWidget({super.key,
  required this.text,
  required this.textColor,
  required this.image,
  required this.backgroundColor,
  required this.statusBarIconBrightness
  });

  @override 
  Widget build(context){
    return  AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: statusBarIconBrightness,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24, vertical: 10
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(image, width: 300,
              ),
              Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                wordSpacing: 5,
              )
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}