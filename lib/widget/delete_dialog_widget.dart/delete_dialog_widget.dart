import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_model/app_ui_style/app_ui_style.dart';

class DeleteDialogWidget extends AlertDialog{
  final int index;
  final VoidCallback firstButtonFunction;
  const DeleteDialogWidget({
  super.key,
  required this.index,
  required this.firstButtonFunction});

  @override
  Widget build(context){
    final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context);
    return AlertDialog(
            title: Text("Deletion",
                style: TextStyle(
                  color: appUiStyle.setTextTheme(),
                )),
            backgroundColor: appUiStyle.setBackgroundTheme(),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Text("Are you sure ?",
                style: TextStyle(
                  color: appUiStyle.setTextTheme(),
                  
                  )),
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