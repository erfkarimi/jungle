import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel{
  @HiveField(0)
   String title;
  @HiveField(1)
   String description;

  TaskModel(
    this.title,
    this.description
  );
}