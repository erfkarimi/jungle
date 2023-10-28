import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jungle/model/task_model/task_model.dart';
import 'package:jungle/model/todo_model/todo_model.dart';
import 'package:jungle/view_model/db_counter_state/db_counter_state.dart';
import 'package:jungle/view_model/app_ui_style/app_ui_style.dart';
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
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_)=> AppUiStyle()),
          ChangeNotifierProvider(
          create: (_)=> DbCounterState()),
      ],
      child: const App(),
      ));
}