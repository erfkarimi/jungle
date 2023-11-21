import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteDialogWidget extends AlertDialog{
  final int index;
  final VoidCallback firstButtonFunction;
  const DeleteDialogWidget({
  super.key,
  required this.index,
  required this.firstButtonFunction});

  @override
  Widget build(context){
    return AlertDialog(
            title: const Text("Deletion",
                style: TextStyle(
                )),
            content: const Text("Would you like to delete this task?"),
            actions: [
              TextButton(
                onPressed: firstButtonFunction,
                child: const Text(
                  "Delete",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                    ),),
              ),
              TextButton(
                onPressed: ()=> Get.back(),
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                    ),
                ),
              )
            ]
          );
  }
}