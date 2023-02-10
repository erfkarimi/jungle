import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'app/app.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("welcomePage");
  runApp(const App());
}