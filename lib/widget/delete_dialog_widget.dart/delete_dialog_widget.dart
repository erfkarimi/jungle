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
            content: const Text("Are you sure ?"),
            actions: [
              TextButton(
                onPressed: firstButtonFunction,
                child: const Text(
                  "Yes",
                  style: TextStyle(
                    color: Colors.blue,
                    
                    ),),
              ),
              TextButton(
                onPressed: ()=> Get.back(),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.red.shade600,
                    ),
                ),
              )
            ]
          );
  }
}