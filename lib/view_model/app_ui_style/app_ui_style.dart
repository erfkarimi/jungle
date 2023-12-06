import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
export 'package:provider/provider.dart';

class AppUiStyle extends ChangeNotifier {
  bool darkTheme = false;

  Color setTextTheme() => darkTheme ? Colors.white : Colors.black;

  Color setBackgroundTheme() => darkTheme ? Colors.grey.shade900 : Colors.white;

  Color setDescriptionTheme() =>
      darkTheme ? Colors.grey.shade100 : Colors.grey.shade600;

  Color snackBarTheme() =>
      darkTheme ? Colors.teal.shade900 : Colors.teal.shade100;

  void saveToDb(bool value) {
    final Box settingsBox = Hive.box("settings");
    settingsBox.put("darkTheme", value);
    notifyListeners();
  }
}
