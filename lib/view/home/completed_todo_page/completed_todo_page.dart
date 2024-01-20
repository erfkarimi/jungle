import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jungle/constant/snack_bar/snack_bar.dart';
import 'package:jungle/widget/delete_dialog_widget.dart/delete_dialog_widget.dart';
import '../../../../model/todo_model/todo_model.dart';
import '../../service/notification_service/notification_service.dart';
import 'edit_completed_todo_page.dart';

class CompletedTodo extends StatefulWidget {
  const CompletedTodo({super.key});
  @override
  CompletedTodoState createState() => CompletedTodoState();
}

class CompletedTodoState extends State<CompletedTodo> {
  final Box<TodoModel> completedTodoBox = Hive.box<TodoModel>("completed");
  final Box<TodoModel> todoBox = Hive.box<TodoModel>("todo");

  @override
  Widget build(context) {
    return Scaffold(body: buildBody());
  }

  Widget buildBody() {
    return ValueListenableBuilder(
        valueListenable: completedTodoBox.listenable(),
        builder: (context, completedTodoBox, _) {
          if (completedTodoBox.isEmpty) {
            return showNoCompletedTodo();
          } else {
            return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: completedTodoBox.length,
                  (context, int index) {
                  index = completedTodoBox.length - 1 - index;
                  return completedTodoButton(index);
                }
                ))
            ],
          ).paddingSymmetric(horizontal: 10);
          }
          
        });
  }

  Widget completedTodoButton(int index) {
    final completedTodo = completedTodoBox.getAt(index) as TodoModel;
    final String title = completedTodo.title ?? "";
    final String description = completedTodo.description ?? "";
    return MaterialButton(
      onPressed: () {
        Get.to(() => EditCompletedTodoPage(index: index),
            transition: Transition.cupertino);
      },
      onLongPress: () => deleteDoneTodoOnLongPressDialog(context, index),
      height: 50,
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: IconButton(
          onPressed: () {
            setState(() {
              completedTodoBox.deleteAt(index);
              todoBox.add(completedTodo);
              showMarkedUncompletedSnackBar(context);
            });
          },
          icon: const Icon(
            Icons.task_alt_outlined,
            color: Colors.teal,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.lineThrough),
        ),
        subtitle: description.isEmpty
            ? null
            : Text(
                description,
                maxLines: 2,
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
              width: 250,
            ),
            const Text(
              "Nothing is completed",
              style: TextStyle(
                fontSize: 17,
              ),
            )
          ],
        ),
      ),
    );
  }

  void deleteDoneTodoOnLongPressDialog(
    BuildContext context,
    int index,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          return DeleteDialogWidget(
            index: index,
            firstButtonFunction: () {
              completedTodoBox.deleteAt(index);
              NotificationService()
                  .cancelNotification(completedTodoBox.getAt(index)!.id);
              Get.back();
            },
          );
        });
  }
}
