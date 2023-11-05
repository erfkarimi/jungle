import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jungle/widget/delete_dialog_widget.dart/delete_dialog_widget.dart';
import 'package:jungle/widget/leading_button_widget/leading_button_widget.dart';
import 'package:jungle/widget/text_button_widget/text_button_widget.dart';
import '../../../constant/palette/palette.dart';
import '../../../model/todo_model/todo_model.dart';
import '../../../view_model/app_ui_style/app_ui_style.dart';
import '../../../view_model/db_counter_state/db_counter_state.dart';

class EditCompletedTodoPage extends StatelessWidget {
  final int index;
  const EditCompletedTodoPage({super.key, required this.index});

  @override
  Widget build(context) {
    final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context);
    final Box<TodoModel> completedTodoBox = Hive.box<TodoModel>("completed");
    final completedTodoModel = completedTodoBox.getAt(index) as TodoModel;
    return Scaffold(
      backgroundColor: appUiStyle.setAppBarTheme(),
      appBar: buildAppBar(context, appUiStyle,
      completedTodoBox, completedTodoModel),
      body: buildBody(appUiStyle, completedTodoModel),
    );
  } 

  AppBar buildAppBar(BuildContext context, AppUiStyle appUiStyle,
      Box<TodoModel> completedTodoBox, TodoModel todoModel) {
    return AppBar(
      backgroundColor: appUiStyle.setAppBarTheme(),
      title: Text(
        "Edit completed todo",
        style: TextStyle(
          color: appUiStyle.setTextTheme(),
          fontFamily: appUiStyle.font
        ),
      ),
      leading: LeadingButtonWidget(appUiStyle: appUiStyle),
      actions: [
        updateCompletedTodoButton(completedTodoBox, todoModel),
        deleteCompletedTodoButton(context, completedTodoBox)
      ],
    );
  }

  Widget buildBody(AppUiStyle appUiStyle, TodoModel todoModel) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            titleTextField(appUiStyle, todoModel),
            const SizedBox(height: 10),
            descriptionTextField(appUiStyle, todoModel),
          ],
        ),
      ),
    );
  }

  Widget titleTextField(AppUiStyle appUiStyle, TodoModel todo) {
    return TextFormField(
      cursorColor: Palette.ultramarineBlue,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.next,
      style: TextStyle(
        color: appUiStyle.setTextTheme(),
        fontWeight: FontWeight.bold,
        fontFamily: appUiStyle.font,
        fontSize: 18,
        ),
      initialValue: todo.title,
      decoration: InputDecoration(
          hintText: "Title",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontFamily: appUiStyle.font
            ),
          border: InputBorder.none),
      onChanged: (String value)=> todo.title = value
    );
  }

  Widget descriptionTextField(AppUiStyle appUiStyle, TodoModel todo) {
    return TextFormField(
      cursorColor: Palette.ultramarineBlue,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.newline,
      style: TextStyle(
        color: appUiStyle.setTextTheme(),
        fontFamily: appUiStyle.font),
      maxLines: 20,
      initialValue: todo.description,
      decoration: InputDecoration(
        hintText: "Description",
        hintStyle: TextStyle(
          color: Colors.grey, fontFamily: appUiStyle.font),
        border: InputBorder.none
      ),
      onChanged: (String value)=> todo.description = value
    );
  }

  Widget updateCompletedTodoButton(
      Box<TodoModel> completedTodoBox, TodoModel completedTodoModel) {
    return TextButtonWidget(
      function: () {
        completedTodoBox.putAt(
            index,
            TodoModel(
              completedTodoModel.title,
              completedTodoModel.description,
            ));
        Get.back();
      },
      buttonTitle: "Update",
        color: Colors.blue,
    );
  }

  Widget deleteCompletedTodoButton(BuildContext context,
      Box<TodoModel> completedTodoBox,) {
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
          return Consumer<DbCounterState>(
            builder: (context, dbCounterState, _) {
              return DeleteDialogWidget(
                index: index,
                firstButtonFunction: (){
                  completedTodoBox.deleteAt(index);
                    dbCounterState.updateCompletedCounter(completedTodoBox.length);
                    dbCounterState.saveDbCounterState();
                    Get.back();
                    Get.back();
                  },
                );
                },
                
              );
            }
          );
        }
}