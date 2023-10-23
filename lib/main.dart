import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jungle/model/task_model/task_model.dart';
import 'package:jungle/model/todo_model/todo_model.dart';
import 'package:jungle/view_model/set_theme/set_theme.dart';
import 'app/app.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var appDocumentDirectory = 
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(TodoModelAdapter());
  await Hive.openBox<TaskModel>("task");
  await Hive.openBox<TodoModel>("todo");
  await Hive.openBox<TodoModel>("completed");
  await Hive.openBox("welcome");
  runApp(
    ChangeNotifierProvider(
      create: (_)=> SetTheme(),
      child: App()));
}