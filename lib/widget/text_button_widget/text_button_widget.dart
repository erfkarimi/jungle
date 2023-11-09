import 'package:flutter/material.dart';
import 'package:jungle/view_model/app_ui_style/app_ui_style.dart';

class TextButtonWidget extends StatelessWidget{
  final VoidCallback? function;
  final String buttonTitle;
  final Color color;
  const TextButtonWidget({
    super.key,
    required this.function,
    required this.buttonTitle,
    required this.color
    });

  @override
  Widget build(context){
    final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context);
    return TextButton(
      onPressed: function,
      child: Text(
        buttonTitle,
        style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold,
          color: color,
          fontFamily: appUiStyle.font
          ),
      ),
    );
  }
}
