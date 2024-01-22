import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jungle/view/home/task_page/new_task_sheet.dart';
import 'package:jungle/view/service/notification_service/notification_service.dart';
import 'package:jungle/widget/delete_dialog_widget.dart/delete_dialog_widget.dart';
import '../../../constant/snack_bar/snack_bar.dart';
import '../../../model/todo_model/todo_model.dart';
import 'edit_task.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  TaskPageState createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage> {
  final Box<TodoModel> todoBox = Hive.box<TodoModel>("todo");
  final Box<TodoModel> completedTodoBox = Hive.box<TodoModel>("completed");

  @override
  Widget build(context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: floatingActionButton(),
        body: buildBody());
  }

  Widget buildBody() {
    return ValueListenableBuilder(
        valueListenable: todoBox.listenable(),
        builder: (context, todoBox, __) {
          if (todoBox.isEmpty) {
            return showNoTodo();
          }
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: todoBox.length,
                  (context, int index) {
                  index = todoBox.length - 1 - index;
                  return todoButton(index);
                }
                ))
            ],
          ).paddingSymmetric(horizontal: 10);
        });
  }

  Widget todoButton(int index) {
    final todo = todoBox.getAt(index) as TodoModel;
    final String todoTitle = todo.title ?? "";
    final String todoDescription = todo.description ?? "";
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
              todoBox.deleteAt(index);
              completedTodoBox.add(todo);
            });
          },
        ),
        title: Text(
          todoTitle,
          maxLines: 2,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: todoDescription.isEmpty
            ? null
            : Text(
                todoDescription,
                maxLines: 2,
              ),
        trailing: todo.dateTime != null
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
            const Text(
              "No task",
              style: TextStyle(
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
      tooltip: "Add new todo",
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
              if (todoBox.getAt(index)!.dateTime != null) {
                NotificationService()
                    .cancelNotification(todoBox.getAt(index)!.id);
              }
              todoBox.deleteAt(index);
              Get.back();
            },
          );
        });
  }

}
