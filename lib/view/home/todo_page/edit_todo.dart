import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:jungle/constant/snack_bar/snack_bar.dart';
import 'package:jungle/view/service/notification_service/notification_service.dart';
import 'package:jungle/widget/delete_dialog_widget.dart/delete_dialog_widget.dart';
import 'package:jungle/widget/leading_button_widget/leading_button_widget.dart';
import '../../../model/todo_model/todo_model.dart';
import '../../../widget/text_button_widget/text_button_widget.dart';

class EditTodoPage extends StatefulWidget {
  final int index;
  const EditTodoPage({super.key, required this.index});

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final Box<TodoModel> todoBox = Hive.box<TodoModel>("todo");
  final Box<TodoModel> completedTodoBox = Hive.box<TodoModel>("completed");
  String title = "";
  String description = "";
  DateTime? dateTime;
  TimeOfDay? timeOfDay;
  int? id;

  @override
  Widget build(context) {
    final todoModel = todoBox.getAt(widget.index) as TodoModel;
    return Scaffold(
      appBar: buildAppBar(context, todoBox, todoModel),
      body: buildBody(context, todoModel),
    );
  }

  AppBar buildAppBar(
    BuildContext context,
    Box<TodoModel> todoBox,
    TodoModel todoModel,
  ) {
    return AppBar(
      title: const Text("Edit task"),
      leading: LeadingButtonWidget(),
      actions: [deleteTodoButton()],
    );
  }

  Widget buildBody(
    BuildContext context,
    TodoModel todoModel,
  ) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  titleTextField(todoModel),
                  timeAndDateWidget(todoModel),
                  descriptionTextField(todoModel),
                  markCompButtonWidget(todoModel)
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  Widget titleTextField(TodoModel todo) {
    return TextFormField(
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.next,
        maxLines: null,
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
            prefixIcon: Icon(Icons.tag),
            border: InputBorder.none),
        onChanged: (String value) {
          setState(() {
            todoBox.putAt(
                widget.index,
                TodoModel(
                    title: value,
                    description: todo.description,
                    dateTime: todo.dateTime,
                    timeOfDay: todo.timeOfDay,
                    id: todo.id));
            if (todo.dateTime != null && todo.timeOfDay != null) {
              if (todo.dateTime!.day >= DateTime.now().day &&
                  todo.dateTime!.month >= DateTime.now().month) {
                NotificationService().cancelNotification(todo.id);
                NotificationService().createScheduleNotification(TodoModel(
                    title: value,
                    description: todo.description,
                    dateTime: todo.dateTime,
                    timeOfDay: todo.timeOfDay,
                    id: todo.id));
              }
            }
          });
        });
  }

  Widget timeAndDateWidget(TodoModel todoModel) {
    DateFormat currentDate = DateFormat("yyyy-MM-dd");
    DateTime date = todoModel.dateTime ?? DateTime.now();
    TimeOfDay time = todoModel.timeOfDay ?? TimeOfDay.now();
    String formattedDate = Jiffy.parse(currentDate.format(date)).MMMEd;

    if (todoModel.dateTime != null && todoModel.timeOfDay != null) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Icon(Icons.schedule),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(context).textTheme.bodyMedium!.color ??
                        Colors.white,
                  )),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "$formattedDate, ${time.format(context)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                      width: 22,
                      height: 22,
                      child: IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            setState(() {
                              NotificationService().cancelNotification(
                                  todoBox.getAt(widget.index)!.id);
                              todoBox.putAt(
                                  widget.index,
                                  TodoModel(
                                      title: todoModel.title,
                                      description: todoModel.description,
                                      dateTime: null,
                                      timeOfDay: null,
                                      id: todoModel.id));
                            });
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 20,
                          )))
                ],
              ),
            ),
          ],
        ),
      );
    }
    return const Text("");
  }

  Widget descriptionTextField(TodoModel todo) {
    return TextFormField(
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.newline,
        maxLines: null,
        initialValue: todo.description,
        decoration: const InputDecoration(
            hintText: "Description",
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            border: InputBorder.none),
        onChanged: (String value) {
          setState(() {
            todoBox.putAt(
                widget.index,
                TodoModel(
                    title: todo.title,
                    description: value,
                    dateTime: todo.dateTime,
                    timeOfDay: todo.timeOfDay,
                    id: todo.id));
            if (todo.dateTime != null && todo.timeOfDay != null) {
              if (todo.dateTime!.day >= DateTime.now().day &&
                  todo.dateTime!.month >= DateTime.now().month) {
                NotificationService().cancelNotification(todo.id);
                NotificationService().createScheduleNotification(TodoModel(
                    title: todo.title,
                    description: value,
                    dateTime: todo.dateTime,
                    timeOfDay: todo.timeOfDay,
                    id: todo.id));
              }
            }
          });
        });
  }


  Widget markCompButtonWidget(TodoModel todoModel){
    return Expanded(
      child: Align(
        alignment: Alignment.bottomRight,
        child: TextButton(
          onPressed: (){
            Get.back();
            todoBox.deleteAt(widget.index);
            completedTodoBox.add(todoModel);
            showMarkedCompletedSnackBar(context);
          },
          child: const Text(
            "Mark completed",
            style: TextStyle(fontWeight: FontWeight.bold),),
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
                  .cancelNotification(todoBox.getAt(widget.index)?.id);
              todoBox.deleteAt(widget.index);
              Get.back();
              Get.back();
            },
          );
        });
  }
}
