import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:jungle/model/todo_model/todo_model.dart';


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
  Future<void> createScheduleNotification(TodoModel todoModel) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: todoModel.id ?? 0,
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
                actionType: ActionType.DismissAction
              )
            ]
            );
  }
}

