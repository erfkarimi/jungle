import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
export 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel{

  @HiveField(0)
  String? title;

  @HiveField(1)
  String? description;

  @HiveField(2)
  TimeOfDay? timeOfDay;

  @HiveField(3)
  DateTime? dateTime;

  @HiveField(4)
  int? id;

  @HiveField(5)
  bool titleRTL;

  @HiveField(6)
  bool descriptionRTL;

  TaskModel(
    {this.title,
    this.description,
    this.timeOfDay,
    this.dateTime,
    this.id,
    required this.titleRTL,
    required this.descriptionRTL
    }
  );
}