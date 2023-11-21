import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:jungle/widget/delete_dialog_widget.dart/delete_dialog_widget.dart';
import 'package:jungle/widget/leading_button_widget/leading_button_widget.dart';
import 'package:jungle/widget/text_button_widget/text_button_widget.dart';
import '../../../constant/palette/palette.dart';
import '../../../model/todo_model/todo_model.dart';

class EditTodoPage extends StatelessWidget {
  final int index;
  const EditTodoPage({super.key, required this.index});

  @override
  Widget build(context) {
    
    final Box<TodoModel> todoBox = Hive.box<TodoModel>("todo");
    
    final todoModel = todoBox.getAt(index) as TodoModel;
    return Scaffold(
      appBar: buildAppBar(context, todoBox, todoModel),
      body: buildBody(context,todoModel),
    );
  }

  AppBar buildAppBar(BuildContext context,
      Box<TodoModel> todoBox,
      TodoModel todoModel,
      ) {
    return AppBar(
      title: const Text(
        "Edit todo"),
      leading: LeadingButtonWidget(),
      actions: [
        updateTodoButton(todoBox, todoModel),
        const SizedBox(width: 10),
        deleteTodoButton(context, todoBox)
      ],
    );
  }

  Widget buildBody(BuildContext context, TodoModel todoModel,) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            titleTextField(todoModel),
            const SizedBox(height: 10),
            //timeAndDateWidget(context, todoModel),
            const SizedBox(width: 10),
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


  Widget timeAndDateWidget(
    BuildContext context,
    TodoModel todoModel){
    DateFormat currentDate = DateFormat("yyyy-MM-dd");
    TimeOfDay presentTime = TimeOfDay.now();
    DateTime presentDate = DateTime.now();
    String date = Jiffy.parse(currentDate.format(todoModel.dateTime)).yMMMEd;
    String time = todoModel.timeOfDay.format(context);

    if(todoModel.dateTime != presentDate 
      && todoModel.timeOfDay != presentTime){
      return Row(
      children: [
        const Icon(Icons.schedule),
        TextButton(
          onPressed: (){},
          child: Text(
            "$date, $time",
            style: const TextStyle(
              fontWeight: FontWeight.bold
            )
          ),
        ),
      ],
    );
  } else {
    return Row(
      children: [
        const Icon(Icons.schedule),
        TextButton(
          onPressed: (){},
          child: const Text(
            "Set time/date",
            style: TextStyle(
              fontWeight: FontWeight.bold
            )
          ),
        ),
      ],
    );
  } 
    
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
        updateTodo(todoModel, todoBox, index);
        Get.back();
      },
      buttonTitle: "Update",
      color: Colors.blue,
    );
  }

  void updateTodo(TodoModel todoModel, Box<TodoModel> todoBox ,int index){
    final TodoModel updateTodoModel = TodoModel()
              ..title = todoModel.title
              ..description = todoModel.description
              ..timeOfDay = TimeOfDay.now()
              ..dateTime = DateTime.now();
    todoBox.putAt(index, updateTodoModel);
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