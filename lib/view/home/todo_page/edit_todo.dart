import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../../model/palette/palette.dart';
import '../../../model/todo_model/todo_model.dart';
import '../../../view_model/app_ui_style/app_ui_style.dart';

class EditTodoPage extends StatelessWidget {
  final int index;
  const EditTodoPage({super.key, required this.index});

  @override
  Widget build(context) {
    final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context);
    final Box<TodoModel> todoBox = Hive.box<TodoModel>("todo");
    final todo = todoBox.getAt(index) as TodoModel;
    return Scaffold(
      backgroundColor: appUiStyle.setAppBarTheme(),
      appBar: buildAppBar(context, appUiStyle, todoBox, todo),
      body: buildBody(context, appUiStyle, todoBox, todo),
    );
  }

  AppBar buildAppBar(BuildContext context, AppUiStyle appUiStyle,
      Box<TodoModel> todoBox, TodoModel todoModel) {
    return AppBar(
      backgroundColor: appUiStyle.setAppBarTheme(),
      title: Text(
        "Edit todo",
        style: TextStyle(color: appUiStyle.setTextTheme()),
      ),
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: MaterialButton(
          onPressed: () {
            Get.back();
          },
          minWidth: 10,
          shape:
              CircleBorder(side: BorderSide(color: appUiStyle.setTextTheme())),
          child: Icon(Icons.arrow_back, color: appUiStyle.setTextTheme()),
        ),
      ),
      actions: [
        updateTodoButton(context, appUiStyle, todoBox, todoModel, index),
        const SizedBox(width: 10),
        deleteTodoButton(context, appUiStyle, todoBox, index)
      ],
    );
  }

  Widget buildBody(BuildContext context, AppUiStyle appUiStyle,
      Box<TodoModel> todoBox, TodoModel todoModel) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            titleTextField(context, appUiStyle, todoModel),
            const SizedBox(height: 10),
            descriptionTextField(context, appUiStyle, todoModel),
          ],
        ),
      ),
    );
  }

  Widget titleTextField(
      BuildContext context, AppUiStyle appUiStyle, TodoModel todo) {
    return SizedBox(
        height: 50,
        child: TextFormField(
          cursorColor: Palette.ultramarineBlue,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.next,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: appUiStyle.setTextTheme()),
          initialValue: todo.title,
          decoration: const InputDecoration(
              hintText: "Title",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none),
          onChanged: (String value) {
            todo.title = value;
          },
        ));
  }

  Widget descriptionTextField(
      BuildContext context, AppUiStyle appUiStyle, TodoModel todo) {
    return TextFormField(
      cursorColor: Palette.ultramarineBlue,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.newline,
      style: TextStyle(color: appUiStyle.setTextTheme()),
      maxLines: 20,
      initialValue: todo.description,
      decoration: const InputDecoration(
          hintText: "Description",
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none),
      onChanged: (String value) {
        todo.description = value;
      },
    );
  }

  Widget updateTodoButton(BuildContext context, AppUiStyle appUiStyle,
      Box<TodoModel> todoBox, TodoModel todo, int index) {
    return TextButton(
      onPressed: () {
        todoBox.putAt(
            index,
            TodoModel(
              todo.title,
              todo.description,
            ));
        Navigator.of(context).pop();
      },
      child: const Text(
        "Update",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget deleteTodoButton(
    BuildContext context, AppUiStyle appUiStyle,
      Box<TodoModel> todoBox, int index
  ){
    return TextButton(
      onPressed: () {
        deleteTaskDialog(context, appUiStyle, todoBox, index);
      },
      child: Text(
        "Delete",
        style: TextStyle(
            color: Colors.red.shade600,
            fontWeight: FontWeight.bold,
            fontSize: 16),
      ),
    );
  }

  void deleteTaskDialog(BuildContext context, AppUiStyle appUiStyle,
      Box<TodoModel> todoBox, int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Deletion",
                style: TextStyle(color: appUiStyle.setTextTheme())),
            backgroundColor: appUiStyle.setBackgroundTheme(),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Text("Are you sure ?",
                style: TextStyle(color: appUiStyle.setTextTheme())),
            actions: [
              TextButton(
                onPressed: () {
                  todoBox.deleteAt(index);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text("Yes"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red.shade600),
                ),
              )
            ],
          );
        });
  }
}
