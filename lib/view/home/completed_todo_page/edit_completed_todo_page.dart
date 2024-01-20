import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:jungle/widget/delete_dialog_widget.dart/delete_dialog_widget.dart';
import 'package:jungle/widget/leading_button_widget/leading_button_widget.dart';
import 'package:jungle/widget/text_button_widget/text_button_widget.dart';
import 'package:jungle/widget/time_date_widget/time_date_widget.dart';
import '../../../constant/snack_bar/snack_bar.dart';
import '../../../model/todo_model/todo_model.dart';
import '../../service/notification_service/notification_service.dart';

class EditCompletedTodoPage extends StatefulWidget {
  final int index;
  const EditCompletedTodoPage({super.key, required this.index});

  @override
  State<EditCompletedTodoPage> createState() => _EditCompletedTodoPageState();
}

class _EditCompletedTodoPageState extends State<EditCompletedTodoPage> {
  final Box<TodoModel> todoBox = Hive.box<TodoModel>("todo");
  final Box<TodoModel> compTodoBox = Hive.box<TodoModel>("completed");
  String title = "";
  String description = "";
  DateTime? dateTime;
  TimeOfDay? timeOfDay;

  @override
  Widget build(context) {
    final compTodoModel = compTodoBox.getAt(widget.index) as TodoModel;
    return Scaffold(
      appBar: buildAppBar(compTodoModel),
      body: buildBody(compTodoModel),
    );
  }

  AppBar buildAppBar(TodoModel compTodo) {
    return AppBar(
      title: const Text(
        "Edit (completed)",
      ),
      leading: LeadingButtonWidget(),
      actions: [deleteCompletedTodoButton()],
    );
  }

  Widget buildBody(TodoModel compTodo) {
    return LayoutBuilder(builder: (context, constraint) {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: IntrinsicHeight(
            child: Column(
              children: [
                titleTextField(compTodo),
                timeAndDateWidget(compTodo),
                descriptionTextField(compTodo),
                const Expanded(child: SizedBox()),
                markUncompletedButtonWidget(compTodo)
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget titleTextField(TodoModel compTodo) {
    return TextFormField(
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.next,
        maxLines: null,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        initialValue: compTodo.title,
        decoration: const InputDecoration(
            hintText: "Title",
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            prefixIcon: Icon(Icons.tag),
            border: InputBorder.none),
        onChanged: (String value) {
          setState(() {
            compTodoBox.putAt(
                widget.index,
                TodoModel(
                    title: value,
                    description: compTodo.description,
                    dateTime: compTodo.dateTime,
                    timeOfDay: compTodo.timeOfDay));
          });
        });
  }

  Widget timeAndDateWidget(TodoModel compTodo) {
    DateFormat currentDate = DateFormat("yyyy-MM-dd");
    DateTime date = compTodo.dateTime ?? DateTime.now();
    TimeOfDay time = compTodo.timeOfDay ?? TimeOfDay.now();
    String formattedDate = Jiffy.parse(currentDate.format(date)).MMMEd;

    return TimeDateWidget(
        time: time.format(context),
        date: formattedDate,
        todoModel: compTodo,
        onFunction: () {
          setState(() {
            NotificationService()
                .cancelNotification(compTodoBox.getAt(widget.index)!.id);
            compTodoBox.putAt(
                widget.index,
                TodoModel(
                    title: compTodo.title,
                    description: compTodo.description,
                    dateTime: null,
                    timeOfDay: null,
                    id: compTodo.id));
          });
        });
  }

  Widget descriptionTextField(TodoModel compTodo) {
    return TextFormField(
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.newline,
        maxLines: null,
        initialValue: compTodo.description,
        decoration: const InputDecoration(
            hintText: "Description",
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            border: InputBorder.none),
        onChanged: (String value) {
          setState(() {
            compTodoBox.putAt(
                widget.index,
                TodoModel(
                    title: compTodo.title,
                    description: value,
                    dateTime: compTodo.dateTime,
                    timeOfDay: compTodo.timeOfDay));
          });
        });
  }

  Widget markUncompletedButtonWidget(TodoModel compTodo) {
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton(
        onPressed: () {
          Get.back();
          compTodoBox.deleteAt(widget.index);
          todoBox.add(compTodo);
          showMarkedUncompletedSnackBar(context);
        },
        child: const Text(
          "Mark uncompleted",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget deleteCompletedTodoButton() {
    return TextButtonWidget(
      function: () => deleteCompletedTodoDialog(),
      buttonTitle: "Delete",
      color: Colors.red.shade600,
    );
  }

  void deleteCompletedTodoDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return DeleteDialogWidget(
            index: widget.index,
            firstButtonFunction: () {
              compTodoBox.deleteAt(widget.index);
              Get.back();
              Get.back();
            },
          );
        });
  }
}
