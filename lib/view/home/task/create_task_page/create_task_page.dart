import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:jungle/view_model/db_counter_state/db_counter_state.dart';
import 'package:provider/provider.dart';
import '../../../../model/palette/palette.dart';
import '../../../../model/task_model/task_model.dart';
import '../../../../view_model/set_theme/set_theme.dart';

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
    final SetTheme setTheme = Provider.of<SetTheme>(context);
    var currentDate = formatter.format(dateTime);
    return Scaffold(
        appBar: buildAppBar(
          context,
          setTheme,
          currentDate
        ),
        body: buildBody(context, setTheme, titleController, labelController,
            descriptionController));
  }

  AppBar buildAppBar(
    BuildContext context,
    SetTheme setTheme,
    String currentDate
  ) {
    return AppBar(
      elevation: 0.0,
      title: Text(
        "Create task",
        style: TextStyle(color: setTheme.setTextTheme()),
      ),
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: MaterialButton(
          onPressed: () {
            Get.back();
          },
          minWidth: 10,
          shape: CircleBorder(side: BorderSide(color: setTheme.setTextTheme())),
          child: Icon(Icons.arrow_back, color: setTheme.setTextTheme()),
        ),
      ),
      actions: [
        saveTaskButton(context, titleController, labelController, descriptionController, currentDate)
      ],
    );
  }

  Widget buildBody(
    BuildContext context,
    SetTheme setTheme,
    TextEditingController titleController,
    TextEditingController labelController,
    TextEditingController descriptionController,
  ) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            titleTextField(context, setTheme, titleController),
            const SizedBox(height: 10),
            labelTextField(context, setTheme, labelController),
            const SizedBox(height: 10),
            descriptionTextField(context, setTheme, descriptionController),
          ],
        ),
      ),
    );
  }

  Widget titleTextField(BuildContext context, SetTheme setTheme,
      TextEditingController titleController) {
    return SizedBox(
        height: 50,
        child: TextField(
          cursorColor: Palette.ultramarineBlue,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.next,
          style: TextStyle(
            fontSize: 26,
            color: setTheme.setTextTheme(),
            fontWeight: FontWeight.bold
          ),
          controller: titleController,
          decoration: const InputDecoration(
            hintText: "Title",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 26),
            border: InputBorder.none
            ),

          ),
        );
  }

  Widget labelTextField(BuildContext context, SetTheme setTheme,
      TextEditingController labelController) {
    return SizedBox(
      height: 50,
      child: TextField(
        cursorColor: Palette.ultramarineBlue,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.next,
        style: TextStyle(color: setTheme.setTextTheme()),
        controller: labelController,
        decoration: InputDecoration(
          hintText: "Label",
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.tag,
            color: setTheme.setTextTheme(),)
        ),
      ),
    );
  }

  Widget descriptionTextField(BuildContext context, SetTheme setTheme,
      TextEditingController descriptionController) {
    return TextField(
      cursorColor: Palette.ultramarineBlue,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.newline,
      style: TextStyle(color: setTheme.setTextTheme()),
      maxLines: 10,
      controller: descriptionController,
      decoration: const InputDecoration(
        hintText: "Description",
        hintStyle: TextStyle(color: Colors.grey),
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
    final DbCounterState dbCounterState = Provider.of<DbCounterState>(context);
    
    return TextButton(
      onPressed: () {
        taskBox.add(
          TaskModel(titleController.text, labelController.text,
              descriptionController.text, currentDate),
        );
        dbCounterState.updateTaskCounter(taskBox.length);
        dbCounterState.saveDbCounterState();
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