import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
export 'package:provider/provider.dart';

class AppUiStyle extends ChangeNotifier{
  bool darkTheme = false;
  
  Color setTextTheme()=> darkTheme ? Colors.white : Colors.black;

  Color setBackgroundTheme(){
      return  darkTheme ? Colors.grey.shade900 : Colors.white;
      
  }
        

  Color setDescriptionTheme(){
    if(darkTheme){
      return Colors.grey.shade200;
    }
      return Colors.grey.shade600;
  }

  Color setItemBackgroundTheme(){
    if(darkTheme){
      return Colors.grey.shade800;
    }
    return Colors.grey.shade300;
  }

  void saveToDb(bool value){
    final Box settingsBox = Hive.box("settings");
    settingsBox.put("darkTheme", value);
    notifyListeners();
  }
}