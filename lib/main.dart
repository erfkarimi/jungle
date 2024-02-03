import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jungle/app/app.dart';
import 'package:jungle/model/task_model/task_model.dart';
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
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>("task");
  await Hive.openBox<TaskModel>("completed");
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
        channelGroupKey: 'task_channel_group',
        channelKey: 'task_channel',
        channelName: 'task notification',
        channelDescription: 'To show task notifications',
        defaultColor: const Color(0xff009688),
        importance: NotificationImportance.High,
        ledColor: const Color(0xff009688),
        channelShowBadge: true,
        locked: true
        ),
    ],
    channelGroups: [
    NotificationChannelGroup(
        channelGroupKey: 'task_channel_group',
        channelGroupName: 'Task group')
  ],
    debug: true
    );
}