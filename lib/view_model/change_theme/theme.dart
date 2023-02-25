import 'package:flutter/material.dart';
import 'package:jungle/model/palette/palette.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeTheme extends ChangeNotifier{
  String theme = "light";

  Color changeTextTheme(){
    if(theme == "dark"){
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  Color changeAppBarTheme(){
    if(theme == "dark"){
      return Colors.grey.shade900;
    } else {
      return Palette.copenhagenBlue;
    }
  }

  Color changeBackgroundTheme(){
    if(theme == "dark"){
      return Colors.grey.shade800;
    } else {
      return Colors.white;
    }
  }

  Color changeDescriptionTheme(){
    if(theme == "dark"){
      return Colors.grey.shade200;
    } else {
      return Colors.grey.shade600;
    }
  }

  Color changeTaskTheme(){
    if(theme == "dark"){
      return Colors.grey.shade700;
    } else {
      return Colors.grey.shade200;
    }
  }
  

    Future<void> saveChangeTheme() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("theme", theme);
    notifyListeners();
  }
}