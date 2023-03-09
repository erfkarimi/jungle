import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jungle/model/task_model/task_model.dart';
import 'package:jungle/view_model/change_theme/theme.dart';
import 'app/app.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
   var appDocumentDirectory = 
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox("welcomePage");
  await Hive.openBox<TaskModel>("task");
  runApp(
    ChangeNotifierProvider(
      create: (_)=> ChangeTheme(),
      child: App()));
}