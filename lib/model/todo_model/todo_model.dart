import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
export 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel{

  @HiveField(0)
  late String title;

  @HiveField(1)
  late String description;

  @HiveField(2)
  late TimeOfDay timeOfDay;

  @HiveField(3)
  late DateTime dateTime;
}