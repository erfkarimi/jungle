import 'package:flutter/material.dart';
import 'package:tasks/model/task_model.dart';

class UpdateState with ChangeNotifier{
  final List<TaskModel> tasks = [];

  updateTasksList(TaskModel taskModel){
    tasks.add(taskModel);
    notifyListeners();
  }

  deleteTaskFromTasksList(int index){
    tasks.removeAt(index);
    notifyListeners();
  }
}