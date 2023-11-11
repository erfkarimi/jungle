import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jungle/constant/palette/palette.dart';
import 'package:jungle/widget/leading_button_widget/leading_button_widget.dart';
import 'package:jungle/widget/text_button_widget/text_button_widget.dart';
import '../../../../model/task_model/task_model.dart';
import '../../../../view_model/app_ui_style/app_ui_style.dart';
import '../../../../widget/delete_dialog_widget.dart/delete_dialog_widget.dart';

class EditTaskPage extends StatelessWidget{
    final int index;
    const EditTaskPage({super.key, required this.index});
    @override 
    Widget build(context){
      final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context);
      final Box<TaskModel> taskBox = Hive.box<TaskModel>("task");
      final task = taskBox.getAt(index) as TaskModel;
      return Scaffold(
        appBar: buildAppBar(
          context, taskBox, task, appUiStyle),
        body: buildBody(appUiStyle, task)
      );
    }

    AppBar buildAppBar(
      BuildContext context,
      Box<TaskModel> taskBox,
      TaskModel taskModel,
      AppUiStyle appUiStyle
    ){
      return AppBar(
      title: const Text(
        "Edit task",
        style: TextStyle(
          ),
      ),
      leading: LeadingButtonWidget(appUiStyle: appUiStyle,),
      actions: [
        updateTaskButton(taskBox, taskModel),
        const SizedBox(width: 10),
        deleteTaskButton(context, taskBox)
      ],
    );
    }

    Widget buildBody(AppUiStyle appUiStyle, TaskModel taskModel){
      
      return Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        titleTextField(taskModel),
                        const SizedBox(height: 10),
                        labelTextField(appUiStyle, taskModel),
                        const SizedBox(height: 10),
                        descriptionTextField(taskModel),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                );
  }

  Widget updateTaskButton(
      Box<TaskModel> taskBox,
      TaskModel taskModel
    ){
    return TextButtonWidget(
      function: (){
          taskBox.putAt(index, TaskModel(
            taskModel.title, taskModel.label,
            taskModel.description, taskModel.currentDate
            ));
          Get.back();
      },
      buttonTitle: "Update",
      color: Colors.blue,
    );
  
  }

    Widget deleteTaskButton(
    BuildContext context,
    Box<TaskModel> taskBox
  ){
    return TextButtonWidget(
    function: ()=> deleteTaskDialog(context,taskBox),
    buttonTitle: "Delete",
    color: Colors.red.shade600,
  );
  }

  void deleteTaskDialog(
    BuildContext context,
    Box<TaskModel> taskBox,
    ){
    showDialog(
      context: context,
      builder: (context){
        return DeleteDialogWidget(
          index: index,
          firstButtonFunction: (){
            taskBox.deleteAt(index);
            Get.back();
            Get.back();

          },
        );
      }
    );
  }

    Widget titleTextField(
      TaskModel task
      ){
    return TextFormField(
      cursorColor: Palette.ultramarineBlue,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.next,
      style: const TextStyle(
        fontSize: 26, fontWeight: FontWeight.bold,
        
      ),
      initialValue: task.title,
      decoration: const InputDecoration(
        hintText: "Title",
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        border: InputBorder.none
    ),
    onChanged: (String value)=> task.title = value
    );
  }

  Widget labelTextField(
    AppUiStyle appUiStyle,
    TaskModel taskModel
    ){
    return TextFormField(
      cursorColor: Palette.ultramarineBlue,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.next,
      initialValue: taskModel.label,
      decoration: InputDecoration(
        hintText: "Label",
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        border: InputBorder.none,
        prefixIcon: Icon(Icons.tag,
        color: appUiStyle.setTextTheme(),)
      ),
      onChanged: (String value)=> taskModel.label = value
    );
  }

  Widget descriptionTextField(
    TaskModel taskModel
    ){
    return TextFormField(
      cursorColor: Palette.ultramarineBlue,
      maxLines: 10,
      textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.newline,
      initialValue: taskModel.description,
      decoration: const InputDecoration(
        hintText:  "Description",
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        border: InputBorder.none
      ),
      onChanged: (String value)=> taskModel.description = value
    );
  }
}