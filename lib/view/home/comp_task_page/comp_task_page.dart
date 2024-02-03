import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jungle/constant/snack_bar/snack_bar.dart';
import 'package:jungle/widget/delete_dialog_widget.dart/delete_dialog_widget.dart';
import '../../../../model/task_model/task_model.dart';
import '../../service/notification_service/notification_service.dart';
import 'edit_comp_task_page.dart';
import 'dart:ui' as ui;

class CompTaskPage extends StatefulWidget {
  const CompTaskPage({super.key});
  @override
  CompTaskPageState createState() => CompTaskPageState();
}

class CompTaskPageState extends State<CompTaskPage> {
  final Box<TaskModel> compTaskBox = Hive.box<TaskModel>("completed");
  final Box<TaskModel> todoBox = Hive.box<TaskModel>("task");

  @override
  Widget build(context) {
    return Scaffold(body: buildBody());
  }

  Widget buildBody() {
    return ValueListenableBuilder(
        valueListenable: compTaskBox.listenable(),
        builder: (context, compTaskBox, _) {
          if (compTaskBox.isEmpty) {
            return showNoCompletedTodo();
          } else {
            return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: compTaskBox.length,
                  (context, int index) {
                  index = compTaskBox.length - 1 - index;
                  return compTaskWidget(index);
                }
                ))
            ],
          ).paddingSymmetric(horizontal: 10);
          }
          
        });
  }

  Widget compTaskWidget(int index) {
    final compTask = compTaskBox.getAt(index) as TaskModel;
    final String title = compTask.title ?? "";
    final String description = compTask.description ?? "";
    return MaterialButton(
      onPressed: () {
        Get.to(() => EditCompletedTaskPage(index: index),
            transition: Transition.cupertino);
      },
      onLongPress: () => delCompTaskDialog(context, index),
      height: 50,
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: IconButton(
          onPressed: () {
            setState(() {
              compTaskBox.deleteAt(index);
              todoBox.add(compTask);
              showMarkedUncompSnackBar(context);
            });
          },
          icon: const Icon(
            Icons.task_alt_outlined,
            color: Colors.teal,
          ),
        ),
        title: Text(
          title,
          textDirection: compTask.titleRTL 
          ? ui.TextDirection.rtl : ui.TextDirection.ltr,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.lineThrough),
        ),
        subtitle: description.isEmpty
            ? null
            : Text(
                description,
                maxLines: 2,
                textDirection: compTask.descriptionRTL 
                ? ui.TextDirection.rtl : ui.TextDirection.ltr,
                style: const TextStyle(decoration: TextDecoration.lineThrough),
              ),
      ),
    );
  }

  Widget showNoCompletedTodo() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "asset/image/complete_image.png",
              width: 220,
            ),
            const Text(
              "Nothing is completed",
              style: TextStyle(
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }

  void delCompTaskDialog(
    BuildContext context,
    int index,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          return DeleteDialogWidget(
            index: index,
            firstButtonFunction: () {
              compTaskBox.deleteAt(index);
              NotificationService()
                  .cancelNotification(compTaskBox.getAt(index)!.id);
              Get.back();
            },
          );
        });
  }
}
