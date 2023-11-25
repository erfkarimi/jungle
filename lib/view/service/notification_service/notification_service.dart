import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:jungle/model/todo_model/todo_model.dart';
import 'package:jungle/utility/utility.dart';


class NotificationService{
  // To create Schedule notification
  Future<void> createScheduleNotification(TodoModel todoModel) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: createUniqueID(),
            channelKey: 'todo_channel',
            title: todoModel.title,
            body: todoModel.description,
            notificationLayout: NotificationLayout.Default),
        schedule: NotificationCalendar(
            day: todoModel.dateTime!.day,
            hour: todoModel.timeOfDay!.hour,
            minute: todoModel.timeOfDay!.minute,
            second: 0,
            millisecond: 0,
            repeats: true),
            actionButtons: [
              NotificationActionButton(
                key: "DISMISS",
                label: "${Emojis.symbols_check_mark} Dismiss",
              )
            ]
            );
  }

}

