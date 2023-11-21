import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jungle/widget/delete_dialog_widget.dart/delete_dialog_widget.dart';
import 'package:jungle/widget/leading_button_widget/leading_button_widget.dart';
import 'package:jungle/widget/text_button_widget/text_button_widget.dart';
import '../../../constant/palette/palette.dart';
import '../../../model/todo_model/todo_model.dart';

class EditCompletedTodoPage extends StatelessWidget {
  final int index;
  const EditCompletedTodoPage({super.key, required this.index});

  @override
  Widget build(context) {
    
    final Box<TodoModel> completedTodoBox = Hive.box<TodoModel>("completed");
    final completedTodoModel = completedTodoBox.getAt(index) as TodoModel;
    return Scaffold(
      appBar: buildAppBar(context, completedTodoBox, completedTodoModel),
      body: buildBody(completedTodoModel),
    );
  } 

  AppBar buildAppBar(BuildContext context,
      Box<TodoModel> completedTodoBox, TodoModel todoModel) {
    return AppBar(
      title: const Text(
        "Edit completed todo",
      ),
      leading: LeadingButtonWidget(),
      actions: [
        updateCompletedTodoButton(completedTodoBox, todoModel),
        deleteCompletedTodoButton(context, completedTodoBox)
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
          color: Colors.grey, ),
        border: InputBorder.none
      ),
      onChanged: (String value)=> todo.description = value
    );
  }

  Widget updateCompletedTodoButton(
      Box<TodoModel> completedTodoBox, TodoModel completedTodoModel) {
    return TextButtonWidget(
      function: () {
        updateCompletedTodo(completedTodoModel, completedTodoBox, index);
        Get.back();
      },
      buttonTitle: "Update",
        color: Colors.blue,
    );
  }

  void updateCompletedTodo(
      TodoModel completedTodoModel,
      Box<TodoModel> completedTodoBox, int index){
    final TodoModel updateCompletedTodoModel = TodoModel()
              ..title = completedTodoModel.title
              ..description = completedTodoModel.description
              ..timeOfDay = TimeOfDay.now()
              ..dateTime = DateTime.now();
    completedTodoBox.putAt(index, updateCompletedTodoModel);
  }

  Widget deleteCompletedTodoButton(
    BuildContext context,
    Box<TodoModel> completedTodoBox) {
    return TextButtonWidget(
      function: ()=> deleteCompletedTodoDialog(context, completedTodoBox),
      buttonTitle: "Delete",
        color:Colors.red.shade600,
    );
  }

  void deleteCompletedTodoDialog(BuildContext context,
      Box<TodoModel> completedTodoBox) {
    showDialog(
        context: context,
        builder: (context) {
          return DeleteDialogWidget(
            index: index,
            firstButtonFunction: (){
              completedTodoBox.deleteAt(index);
                Get.back();
                Get.back();
              },
            );
            }
          );
        }
}