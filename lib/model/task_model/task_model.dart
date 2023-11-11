import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel{
  @HiveField(0)
  String title;
  @HiveField(1)
  String label;
  @HiveField(2)
    String description;
  @HiveField(3)
    String currentDate;

  TaskModel(
    this.title,
    this.label,
    this.description,
    this.currentDate
  );
}