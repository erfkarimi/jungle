import 'package:flutter/material.dart';
import 'package:jungle/view_model/app_ui_style/app_ui_style.dart';

class MaterialButtonWidget extends StatelessWidget{
  final VoidCallback function;
  final IconData buttonIcon;
  final String buttonTitle;
  final AppUiStyle appUiStyle;
  final Widget? buttonTrailing;
  const MaterialButtonWidget({
    super.key,
    required this.function,
    required this.buttonIcon,
    required this.buttonTitle,
    required this.appUiStyle,
    this.buttonTrailing
    });

  @override 
  Widget build(context){
    return MaterialButton(
      onPressed: function,
      child: ListTile(
        leading: Icon(
          buttonIcon,
          color: appUiStyle.setTextTheme(),
          ),
          title: Text(
            buttonTitle,
            style: TextStyle(
              color: appUiStyle.setTextTheme(),
            ),
            ),
      )
    );
  }
}