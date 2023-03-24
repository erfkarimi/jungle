import 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel{
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;

  TodoModel(
    this.title,
    this.description,

  );
}