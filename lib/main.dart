import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jungle/app/app.dart';
import 'package:jungle/model/todo_model/todo_model.dart';
import 'package:jungle/view_model/app_ui_style/app_ui_style.dart';
import 'package:jungle/view_model/text_field_validation/text_field_validation.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  notificationInitialization();
    var appDocumentDirectory = 
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.initFlutter();
  Hive.registerAdapter(TimeOfDayAdapter());
  Hive.registerAdapter(TodoModelAdapter());
  await Hive.openBox<TodoModel>("todo");
  await Hive.openBox<TodoModel>("completed");
  await Hive.openBox("settings");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_)=> AppUiStyle()),
        ChangeNotifierProvider(
          create: (_)=> TextFieldValidation(),
          )
      ],
      child: const App(),
      ));
}

void notificationInitialization(){
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: 'todo_channel_group',
        channelKey: 'todo_channel',
        channelName: 'todo notification',
        channelDescription: 'To show todo notifications',
        defaultColor: const Color(0xff009688),
        importance: NotificationImportance.High,
        ledColor: Colors.white,
        channelShowBadge: true,
        ),
    ],
    channelGroups: [
    NotificationChannelGroup(
        channelGroupKey: 'todo_channel_group',
        channelGroupName: 'Task group')
  ],
    debug: true
    );
}