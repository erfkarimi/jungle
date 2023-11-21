import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:jungle/model/todo_model/todo_model.dart';
import 'package:jungle/utility/utility.dart';


Future<void> createScheduleNotification(
  DateTime dateTime, TimeOfDay timeOfDay, TodoModel todoModel
) async{
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueID(),
      channelKey: 'todo_channel',
      title: todoModel.title,
      body: todoModel.description,
      notificationLayout: NotificationLayout.Default
      ),
      schedule: NotificationCalendar(
        day: dateTime.day,
        hour: timeOfDay.hour,
        minute: timeOfDay.minute,
        second: 0,
        millisecond: 0,
        repeats: true
      )
      );
}
