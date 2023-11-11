import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:jungle/widget/leading_button_widget/leading_button_widget.dart';
import '../../../../constant/palette/palette.dart';
import '../../../../model/task_model/task_model.dart';
import '../../../../view_model/app_ui_style/app_ui_style.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {

  
    final TextEditingController titleController = TextEditingController();
    final TextEditingController labelController =
        TextEditingController(text: "No label");
    final TextEditingController descriptionController = TextEditingController();
    final DateTime dateTime = DateTime.now();
    var formatter = DateFormat("yyyy-MM-dd");
    
  
  @override
  Widget build(context) {
    final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context);
    var currentDate = formatter.format(dateTime);
    return Scaffold(
        backgroundColor: appUiStyle.setBackgroundTheme(),
        appBar: buildAppBar(
          context,
          appUiStyle,
          currentDate
        ),
        body: buildBody(context, appUiStyle, titleController, labelController,
            descriptionController));
  }

  AppBar buildAppBar(
    BuildContext context,
    AppUiStyle appUiStyle,
    String currentDate
  ) {
    return AppBar(
      backgroundColor: appUiStyle.setBackgroundTheme(),
      elevation: 0.0,
      title: Text(
        "Create task",
        style: TextStyle(
          color: appUiStyle.setTextTheme(),
          ),
      ),
      leading: LeadingButtonWidget(appUiStyle: appUiStyle),
      actions: [
        saveTaskButton(context, titleController, labelController, descriptionController, currentDate)
      ],
    );
  }

  Widget buildBody(
    BuildContext context,
    AppUiStyle appUiStyle,
    TextEditingController titleController,
    TextEditingController labelController,
    TextEditingController descriptionController,
  ) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            titleTextField(context, appUiStyle, titleController),
            const SizedBox(height: 10),
            labelTextField(context, appUiStyle, labelController),
            const SizedBox(height: 10),
            descriptionTextField(context, appUiStyle, descriptionController),
          ],
        ),
      ),
    );
  }

  Widget titleTextField(BuildContext context, AppUiStyle appUiStyle,
      TextEditingController titleController) {
    return SizedBox(
        height: 50,
        child: TextField(
          cursorColor: Palette.ultramarineBlue,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.next,
          style: TextStyle(
            fontSize: 26,
            color: appUiStyle.setTextTheme(),
            fontWeight: FontWeight.bold,
            
          ),
          controller: titleController,
          decoration: const InputDecoration(
            hintText: "Title",
            hintStyle: TextStyle(
              color: Colors.grey, fontSize: 26,
              
              ),
            border: InputBorder.none
            ),

          ),
        );
  }

  Widget labelTextField(BuildContext context, AppUiStyle appUiStyle,
      TextEditingController labelController) {
    return SizedBox(
      height: 50,
      child: TextField(
        cursorColor: Palette.ultramarineBlue,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.next,
        style: TextStyle(
          color: appUiStyle.setTextTheme(),
          ),
        controller: labelController,
        decoration: InputDecoration(
          hintText: "Label",
          hintStyle: const TextStyle(
            color: Colors.grey, ),
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.tag,
            color: appUiStyle.setTextTheme(),)
        ),
      ),
    );
  }

  Widget descriptionTextField(BuildContext context, AppUiStyle appUiStyle,
      TextEditingController descriptionController) {
    return TextField(
      cursorColor: Palette.ultramarineBlue,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.newline,
      style: TextStyle(
        color: appUiStyle.setTextTheme(), ),
      maxLines: 10,
      controller: descriptionController,
      decoration: const InputDecoration(
        hintText: "Description",
        hintStyle: TextStyle(
          color: Colors.grey,
          ),
        border: InputBorder.none
      ),
    );
  }

  Widget saveTaskButton(
    BuildContext context,
    TextEditingController titleController,
    TextEditingController labelController,
    TextEditingController descriptionController,
    String currentDate,
  ) {
    final taskBox = Hive.box<TaskModel>("task");
    return TextButton(
      onPressed: () {
        taskBox.add(
          TaskModel(titleController.text, labelController.text,
              descriptionController.text, currentDate),
        );
        Navigator.pop(context);
      },
      child: const Text(
        "Save",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold),
      ),
    );
  }
}