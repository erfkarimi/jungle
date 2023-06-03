import 'package:flutter/material.dart';

extension WidgetPaddingX on Widget{
  Widget paddingAll(double padding){
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
      );
  }
}