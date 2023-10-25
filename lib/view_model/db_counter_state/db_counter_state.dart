import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DbCounterState extends ChangeNotifier{
  int taskCounter = 0;
  int todoCounter = 0;
  int completedCounter = 0;
  


  void updateTaskCounter(int counter){
    taskCounter = counter;
    notifyListeners();
  }

  void updateTodoCounter(int counter){
    todoCounter = counter;
    notifyListeners();
  }

  void updateCompletedCounter(int counter){
    completedCounter = counter;
    notifyListeners();
  }

  Future<void> saveDbCounterState() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("taskCounter", taskCounter);
    preferences.setInt("todoCounter", todoCounter);
    preferences.setInt("completedCounter", taskCounter);
  }
}