import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jungle/model_view/change_theme/theme.dart';
import 'app/app.dart';
import 'package:provider/provider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("welcomePage");
  await Hive.openBox("theme");
  runApp(
    ChangeNotifierProvider(
      create: (_)=> ChangeTheme(),
      child: const App()));
}