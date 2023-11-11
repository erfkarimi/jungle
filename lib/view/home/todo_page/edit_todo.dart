import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jungle/widget/delete_dialog_widget.dart/delete_dialog_widget.dart';
import 'package:jungle/widget/leading_button_widget/leading_button_widget.dart';
import 'package:jungle/widget/text_button_widget/text_button_widget.dart';
import '../../../constant/palette/palette.dart';
import '../../../model/todo_model/todo_model.dart';
import '../../../view_model/app_ui_style/app_ui_style.dart';

class EditTodoPage extends StatelessWidget {
  final int index;
  const EditTodoPage({super.key, required this.index});

  @override
  Widget build(context) {
    
    final Box<TodoModel> todoBox = Hive.box<TodoModel>("todo");
    final todoModel = todoBox.getAt(index) as TodoModel;
    return Scaffold(
      appBar: buildAppBar(context, todoBox, todoModel),
      body: buildBody(todoModel),
    );
  }

  AppBar buildAppBar(BuildContext context,
      Box<TodoModel> todoBox, TodoModel todoModel) {
      final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context);
    return AppBar(
      title: const Text(
        "Edit todo"),
      leading: LeadingButtonWidget(appUiStyle: appUiStyle),
      actions: [
        updateTodoButton(todoBox, todoModel),
        const SizedBox(width: 10),
        deleteTodoButton(context, todoBox)
      ],
    );
  }

  Widget buildBody(TodoModel todoModel) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            titleTextField(todoModel),
            const SizedBox(height: 10),
            descriptionTextField(todoModel),
          ],
        ),
      ),
    );
  }

  Widget titleTextField(TodoModel todo) {
    return TextFormField(
      cursorColor: Palette.ultramarineBlue,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.next,
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          ),
      initialValue: todo.title,
      decoration: const InputDecoration(
          hintText: "Title",
          hintStyle: TextStyle(
            color: Colors.grey,
            ),
          border: InputBorder.none),
      onChanged: (String value)=> todo.title = value
    );
  }

  Widget descriptionTextField(TodoModel todo) {
    return TextFormField(
      cursorColor: Palette.ultramarineBlue,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.newline,
      maxLines: 20,
      initialValue: todo.description,
      decoration: const InputDecoration(
          hintText: "Description",
          hintStyle: TextStyle(
            color: Colors.grey,
            ),
          border: InputBorder.none),
      onChanged: (String value)=> todo.description = value
    );
  }

  Widget updateTodoButton(
      Box<TodoModel> todoBox, TodoModel todoModel) {
    return TextButtonWidget(
      function: () {
        todoBox.putAt(
            index,
            TodoModel(
              todoModel.title,
              todoModel.description,
            ));
        Get.back();
      },
      buttonTitle: "Update",
      color: Colors.blue,
    );
  }

  Widget deleteTodoButton(
    BuildContext context,
      Box<TodoModel> todoBox
  ){
    return TextButtonWidget(
      function: ()=> deleteTodoDialog(context, todoBox),
      buttonTitle: "Delete",
      color: Colors.red.shade600);
    }

  void deleteTodoDialog(
    BuildContext context,
      Box<TodoModel> todoBox) {
    showDialog(
        context: context,
        builder: (context) {
          return DeleteDialogWidget(
            index: index,
            firstButtonFunction: (){
              todoBox.deleteAt(index);
              Get.back();
              Get.back();
            },
            );
        });
      }
}