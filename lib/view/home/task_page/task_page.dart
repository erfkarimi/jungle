import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jungle/view/home/task_page/new_task_sheet.dart';
import 'package:jungle/view/service/notification_service/notification_service.dart';
import 'package:jungle/widget/delete_dialog_widget.dart/delete_dialog_widget.dart';
import '../../../constant/snack_bar/snack_bar.dart';
import '../../../model/task_model/task_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'edit_task.dart';
import 'dart:ui' as ui;

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  TaskPageState createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage> {
  final Box<TaskModel> taskBox = Hive.box<TaskModel>("task");
  final Box<TaskModel> compTaskBox = Hive.box<TaskModel>("completed");

  @override
  Widget build(context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: floatingActionButton(),
        body: buildBody());
  }

  Widget buildBody() {
    return ValueListenableBuilder(
        valueListenable: taskBox.listenable(),
        builder: (context, taskBox, __) {
          if (taskBox.isEmpty) {
            return showNoTodo();
          }
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: taskBox.length,
                  (context, int index) {
                  index = taskBox.length - 1 - index;
                  return taskButton(index);
                }
                ))
            ],
          ).paddingSymmetric(horizontal: 10);
        });
  }

  Widget taskButton(int index) {
    final task = taskBox.getAt(index) as TaskModel;
    final String taskTitle = task.title ?? "";
    final String taskDescription = task.description ?? "";
    return MaterialButton(
      onPressed: () {
        Get.to(() => EditTaskPage(index: index),
            transition: Transition.cupertino);
      },
      onLongPress: () => deleteUnDoneTodoOnLongPressDialog(index),
      height: 50,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: Checkbox(
          shape: const CircleBorder(),
          value: false,
          onChanged: (value) {
            setState(() {
              showMarkedCompSnackBar(context);
              taskBox.deleteAt(index);
              compTaskBox.add(task);
            });
          },
        ),
        title: Text(
          taskTitle,
          maxLines: 2,
          textDirection: task.titleRTL
          ? ui.TextDirection.rtl : ui.TextDirection.ltr,
          style: const TextStyle(
            fontWeight: FontWeight.bold),
        ),
        subtitle: taskDescription.isEmpty
            ? null
            : Text(
                taskDescription,
                maxLines: 2,
                textDirection: task.descriptionRTL
                ? ui.TextDirection.rtl : ui.TextDirection.ltr,
              ),
        trailing: task.dateTime != null
        ? Icon(
          Icons.schedule_outlined,
          color: Theme.of(context).listTileTheme.subtitleTextStyle!.color,
          size: 20,
          ) : null
          
      ),
    );
  }

  Widget showNoTodo() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "asset/image/task_image.png",
              width: 220,
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.noTaskText,
              style: const TextStyle(
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }

  void showNewTodoBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return const NewTaskSheet();
            },
          );
        });
  }

  FloatingActionButton floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        showNewTodoBottomSheet();
      },
      tooltip: "Add new task",
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: const Icon(
        Icons.add,
        size: 40,
      ),
    );
  }

  void deleteUnDoneTodoOnLongPressDialog(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return DeleteDialogWidget(
            index: index,
            firstButtonFunction: () {
              if (taskBox.getAt(index)!.dateTime != null) {
                NotificationService()
                    .cancelNotification(taskBox.getAt(index)!.id);
              }
              taskBox.deleteAt(index);
              Get.back();
            },
          );
        });
  }
}