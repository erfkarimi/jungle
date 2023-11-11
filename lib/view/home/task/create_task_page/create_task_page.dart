import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    final taskBox = Hive.box<TaskModel>("task");
    
  
  @override
  Widget build(context) {
    final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context);
    var currentDate = formatter.format(dateTime);
    return Scaffold(
        appBar: buildAppBar(
          context,
          appUiStyle,
          currentDate
        ),
        body: buildBody(context, appUiStyle));
  }

  AppBar buildAppBar(
    BuildContext context,
    AppUiStyle appUiStyle,
    String currentDate
  ) {
    return AppBar(
      elevation: 0.0,
      title: const Text(
        "Create task",
      ),
      leading: LeadingButtonWidget(appUiStyle: appUiStyle),
      actions: [
        saveTaskButton(currentDate)
      ],
    );
  }

  Widget buildBody(
    BuildContext context,
    AppUiStyle appUiStyle,
  ) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            titleTextField(),
            const SizedBox(height: 10),
            labelTextField(appUiStyle),
            const SizedBox(height: 10),
            descriptionTextField(),
          ],
        ),
      ),
    );
  }

  Widget titleTextField() {
    return SizedBox(
        height: 50,
        child: TextField(
          cursorColor: Palette.ultramarineBlue,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.next,
          style: const TextStyle(
            fontSize: 26,
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

  Widget labelTextField(AppUiStyle appUiStyle) {
    return SizedBox(
      height: 50,
      child: TextField(
        cursorColor: Palette.ultramarineBlue,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.next,
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

  Widget descriptionTextField() {
    return TextField(
      cursorColor: Palette.ultramarineBlue,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.newline,
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
    String currentDate,
  ) {
    
    return TextButton(
      onPressed: () {
        taskBox.add(
          TaskModel(titleController.text, labelController.text,
              descriptionController.text, currentDate),
        );
        Get.back();
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