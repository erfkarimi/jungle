import 'package:flutter/material.dart';

class PageWidget extends StatelessWidget{
  final String text;
  final Color textColor;
  final String image;
  final Color backgroundColor;

  const PageWidget({super.key,
  required this.text,
  required this.textColor,
  required this.image,
  required this.backgroundColor

  });

  @override 
  Widget build(context){
    return  Scaffold(
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
    );
  }
}