import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:jungle/constant/snack_bar/snack_bar.dart';
import 'package:jungle/view/service/notification_service/notification_service.dart';
import 'package:jungle/widget/delete_dialog_widget.dart/delete_dialog_widget.dart';
import 'package:jungle/widget/leading_button_widget/leading_button_widget.dart';
import '../../../model/task_model/task_model.dart';
import '../../../widget/text_button_widget/text_button_widget.dart';
import '../../../widget/time_date_widget/time_date_widget.dart';

class EditTaskPage extends StatefulWidget {
  final int index;
  const EditTaskPage({super.key, required this.index});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final Box<TaskModel> taskBox = Hive.box<TaskModel>("task");
  final Box<TaskModel> compTaskBox = Hive.box<TaskModel>("completed");
  String title = "";
  String description = "";
  DateTime? dateTime;
  TimeOfDay? timeOfDay;
  int? id;

  @override
  Widget build(context) {
    final task = taskBox.getAt(widget.index) as TaskModel;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(context, task),
      body: buildBody(context, task),
    );
  }

  AppBar buildAppBar(
    BuildContext context,
    TaskModel task,
  ) {
    return AppBar(
      title: const Text("Edit task"),
      leading: LeadingButtonWidget(),
      actions: [deleteTodoButton()],
    );
  }

  Widget buildBody(
    BuildContext context,
    TaskModel task,
  ) {
    return LayoutBuilder(builder: (context, constraint) {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: IntrinsicHeight(
            child: Column(
              children: [
                titleTextField(task),
                timeAndDateWidget(task),
                descriptionTextField(task),
                const Expanded(child: SizedBox()),
                markCompButtonWidget(task)
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget titleTextField(TaskModel task) {
    return TextFormField(
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.next,
        maxLines: null,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        initialValue: task.title,
        decoration: const InputDecoration(
            hintText: "Title",
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            prefixIcon: Icon(Icons.tag),
            border: InputBorder.none),
        onChanged: (String value) {
          setState(() {
            taskBox.putAt(
                widget.index,
                TaskModel(
                    title: value,
                    description: task.description,
                    dateTime: task.dateTime,
                    timeOfDay: task.timeOfDay,
                    id: task.id));
            if (task.dateTime != null && task.timeOfDay != null) {
              if (task.dateTime!.day >= DateTime.now().day &&
                  task.dateTime!.month >= DateTime.now().month) {
                NotificationService().cancelNotification(task.id);
                NotificationService().createScheduleNotification(TaskModel(
                    title: value,
                    description: task.description,
                    dateTime: task.dateTime,
                    timeOfDay: task.timeOfDay,
                    id: task.id));
              }
            }
          });
        });
  }

  Widget timeAndDateWidget(TaskModel task) {
    DateFormat currentDate = DateFormat("yyyy-MM-dd");
    DateTime date = task.dateTime ?? DateTime.now();
    TimeOfDay time = task.timeOfDay ?? TimeOfDay.now();
    String formattedDate = Jiffy.parse(currentDate.format(date)).MMMEd;

    return TimeDateWidget(
      time: time.format(context),
      date: formattedDate,
      todoModel: task,
      onFunction: () {
        setState(() {
          NotificationService()
              .cancelNotification(taskBox.getAt(widget.index)!.id);
          taskBox.putAt(
              widget.index,
              TaskModel(
                  title: task.title,
                  description: task.description,
                  dateTime: null,
                  timeOfDay: null,
                  id: task.id));
        });
      },
    );
  }

  Widget descriptionTextField(TaskModel task) {
    return TextFormField(
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.newline,
        maxLines: null,
        initialValue: task.description,
        decoration: const InputDecoration(
            hintText: "Description",
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            border: InputBorder.none),
        onChanged: (String value) {
          setState(() {
            taskBox.putAt(
                widget.index,
                TaskModel(
                    title: task.title,
                    description: value,
                    dateTime: task.dateTime,
                    timeOfDay: task.timeOfDay,
                    id: task.id));
            if (task.dateTime != null && task.timeOfDay != null) {
              if (task.dateTime!.day >= DateTime.now().day &&
                  task.dateTime!.month >= DateTime.now().month) {
                NotificationService().cancelNotification(task.id);
                NotificationService().createScheduleNotification(TaskModel(
                    title: task.title,
                    description: value,
                    dateTime: task.dateTime,
                    timeOfDay: task.timeOfDay,
                    id: task.id));
              }
            }
          });
        });
  }

  Widget markCompButtonWidget(TaskModel task) {
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton(
        onPressed: () {
          Get.back();
          taskBox.deleteAt(widget.index);
          compTaskBox.add(task);
          showMarkedCompSnackBar(context);
        },
        child: const Text(
          "Mark completed",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget deleteTodoButton() {
    return TextButtonWidget(
      function: () => deleteTodoDialog(),
      buttonTitle: "Delete",
      color: Colors.red,
    );
  }

  void deleteTodoDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return DeleteDialogWidget(
            index: widget.index,
            firstButtonFunction: () {
              NotificationService()
                  .cancelNotification(taskBox.getAt(widget.index)?.id);
              taskBox.deleteAt(widget.index);
              Get.back();
              Get.back();
            },
          );
        });
  }
}
