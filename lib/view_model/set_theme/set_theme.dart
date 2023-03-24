import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetTheme extends ChangeNotifier{
  String theme = "light";
  bool showTaskPage = true;

  Color setTextTheme(){
    if(theme == "dark"){
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  Color setAppBarTheme(){
    if(theme == "dark"){
      return Colors.grey.shade900;
    } else {
      return Colors.white;
    }
  }

  Color setBackgroundTheme(){
    if(theme == "dark"){
      return Colors.grey.shade800;
    } else {
      return Colors.white;
    }
  }

  Color setDescriptionTheme(){
    if(theme == "dark"){
      return Colors.grey.shade200;
    } else {
      return Colors.grey.shade600;
    }
  }


  Color setTextFieldBorderTheme(){
    if(theme == "dark"){
      return Colors.grey;
    } else {
      return Colors.black;
    }
  }
  

  Future<void> saveChangeTheme() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("theme", theme);
    notifyListeners();
  }

  Future<void> saveStatus() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("showTaskPage", showTaskPage);
    notifyListeners();
  }

}