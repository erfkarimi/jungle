import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppUiStyle extends ChangeNotifier{
  String theme = "light";
  bool showTaskPage = true;
  

  Color setTextTheme(){
    if(theme == "dark" || theme == "dim"){
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  Color setAppBarTheme(){
    if(theme == "dark"){
      return Colors.grey.shade900;
    } else if(theme == "dim"){
        return const Color.fromRGBO(20, 29, 38, 1.0);
    }else {
        return Colors.white;
    }
  }

  Color setBackgroundTheme(){
    if(theme == "dark"){
        return Colors.grey.shade800;
    } else if(theme == "dim") {
        return const Color.fromRGBO(36, 52, 71, 1.0);
    } else {
        return Colors.white;
    }
  }

  Color setDescriptionTheme(){
    if(theme == "dark" || theme == "dim"){
      return Colors.grey.shade200;
    } else {
      return Colors.grey.shade600;
    }
  }


  Color setTextFieldBorderTheme(){
    if(theme == "dark" || theme == "dim"){
      return Colors.grey;
    } else {
      return Colors.black;
    }
  }

  Color setDrawerButtonTheme(){
    if(theme == "dark" || theme == "dim"){
      return Colors.blueGrey.shade800.withOpacity(0.7);
    } else {
      return Colors.blueGrey.shade100;
    }
  }

  Color setItemBackgroundTheme(){
    switch (theme){
      case "dark" :
        return Colors.grey.shade800;
      case "dim" :
        return Colors.blueGrey.shade900;
      default: 
        return Colors.grey.shade300;
      
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