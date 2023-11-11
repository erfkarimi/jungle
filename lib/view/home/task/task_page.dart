import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jungle/constant/palette/palette.dart';
import 'package:jungle/model/task_model/task_model.dart';
import 'package:jungle/view/home/task/edit_task_page/edit_task_page.dart';
import 'package:jungle/view_model/app_ui_style/app_ui_style.dart';
import 'package:get/get.dart';
import 'package:jungle/widget/delete_dialog_widget.dart/delete_dialog_widget.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});
  @override
  TaskPageState createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage> {
  final taskBox = Hive.box<TaskModel>("task");

  @override
  Widget build(context) {
    final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: floatingActionButton(),
      body: buildBody(appUiStyle),
    );
  }

  Widget buildBody(AppUiStyle appUiStyle) {
    return ValueListenableBuilder(
        valueListenable: taskBox.listenable(),
        builder: (context, taskBox, _) {
          if (taskBox.isEmpty) {
            return showNoTask(appUiStyle);
          }
          return Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: taskBox.length,
              itemBuilder: (context, int index) {
                // To reverse elements of list
                index = taskBox.length - 1 - index;
                return GestureDetector(
                  onLongPress: () {
                    deleteTaskOnLongPressDialog(context, index, taskBox);
                  },
                  child: GestureDetector(
                    onTap: () {
                      Get.to(EditTaskPage(index: index),
                          transition: Transition.cupertino);
                    },
                    child: Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    taskBox.getAt(index)!.title,
                                    style: TextStyle(
                                        color: appUiStyle.setTextTheme(),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 2.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Palette.ultramarineBlue),
                                    child: Text(
                                      taskBox.getAt(index)!.label,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  taskBox.getAt(index)!.description,
                                  style: TextStyle(
                                      color: appUiStyle.setDescriptionTheme()),
                                  maxLines: 4,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month_outlined,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    taskBox
                                        .getAt(index)!
                                        .currentDate
                                        .toString(),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                );
              },
            ),
          );
        });
  }

  Widget showNoTask(AppUiStyle appUiStyle) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "asset/image/tasks.png",
              width: 250,
            ),
            const Text(
              "No task",
              style: TextStyle(
                fontSize: 17,
              ),
            )
          ],
        ),
      ),
    );
  }

  FloatingActionButton floatingActionButton() {
    return FloatingActionButton(
      onPressed: () => Get.toNamed("/createTask"),
      tooltip: "Add new task",
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: const Icon(
        Icons.add,
        size: 40,
        color: Colors.white,
      ),
    );
  }

  void deleteTaskOnLongPressDialog(
      BuildContext context, int index, Box<TaskModel> taskBox) {
    showDialog(
        context: context,
        builder: (context) {
          return DeleteDialogWidget(
            index: index,
            firstButtonFunction: () {
              taskBox.deleteAt(index);
              Get.back();
            },
          );
        });
  }
}
