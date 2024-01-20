import 'dart:convert';
import 'dart:io';
import 'package:jungle/model/todo_model/todo_model.dart';

// To generate unique number
int createUniqueID(){
  return DateTime.now().millisecondsSinceEpoch.remainder(10000);
}