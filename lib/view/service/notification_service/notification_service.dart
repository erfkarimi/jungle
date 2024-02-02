import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:jungle/model/task_model/task_model.dart';


class NotificationService{

  // Notification initialization
  Future<void> notificationInitialization() async{
    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod
      );
  }

  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async{
    AwesomeNotifications().getGlobalBadgeCounter().then(
      (value) => AwesomeNotifications().setGlobalBadgeCounter(value - 1));
  }

  static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async{
    AwesomeNotifications().getGlobalBadgeCounter().then(
      (value) => AwesomeNotifications().setGlobalBadgeCounter(value - 1));
  }


  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async{

  }
  // To create Schedule notification
  Future<void> createScheduleNotification(TaskModel task) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: task.id ?? 0,
            channelKey: 'todo_channel',
            title: task.title,
            body: task.description,
            notificationLayout: NotificationLayout.Default),
        schedule: NotificationCalendar(
            day: task.dateTime!.day,
            hour: task.timeOfDay!.hour,
            minute: task.timeOfDay!.minute,
            second: 0,
            millisecond: 0,
            repeats: true),
            actionButtons: [
              NotificationActionButton(
                key: "DISMISS",
                label: "${Emojis.symbols_check_mark} Dismiss",
                actionType: ActionType.DismissAction
              )
            ]
            );
  }

  // To cancel schedule notification
  Future<void> cancelNotification(int? id) async{
    await AwesomeNotifications().cancelSchedule(id ?? 0);
  } 
}

