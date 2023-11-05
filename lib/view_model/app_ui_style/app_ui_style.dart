import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
export 'package:provider/provider.dart';

class AppUiStyle extends ChangeNotifier{
  String theme = "Light";
  bool showTaskPage = true;
  String font = "Regular";
  

  Color setTextTheme(){
    if(theme == "Dark" || theme == "Dim"){
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  Color setAppBarTheme(){
    if(theme == "Dark"){
      return Colors.grey.shade900;
    } else if(theme == "Dim"){
        return const Color.fromRGBO(20, 29, 38, 1.0);
    }else {
        return Colors.white;
    }
  }

  Color setBackgroundTheme(){
    if(theme == "Dark"){
        return Colors.grey.shade800;
    } else if(theme == "Dim") {
        return const Color.fromRGBO(36, 52, 71, 1.0);
    } else {
        return Colors.white;
    }
  }

  Color setDescriptionTheme(){
    if(theme == "Dark" || theme == "Dim"){
      return Colors.grey.shade200;
    } else {
      return Colors.grey.shade600;
    }
  }

  Color setItemBackgroundTheme(){
    switch (theme){
      case "Dark" :
        return Colors.grey.shade800;
      case "Dim" :
        return Colors.blueGrey.shade900;
      default: 
        return Colors.grey.shade300;
      
    }
  }

  void setAppFont(String appFont){
    font = appFont;
    notifyListeners();
  }


  Future<void> saveChangeTheme() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("Theme", theme);
    preferences.setString("Font", font);
    notifyListeners();
  }
}