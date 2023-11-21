import 'package:hive/hive.dart';
export 'package:hive/hive.dart';
part 'notification_model.g.dart';

@HiveType(typeId: 0)
class NotificationModel{

  @HiveField(0)
  late String title;

  @HiveField(1)
  late String time;
}