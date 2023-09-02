import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jungle/model/palette/palette.dart';
import 'package:jungle/model/task_model/task_model.dart';
import 'package:jungle/view/add_task/add_task.dart';
import 'package:jungle/view/home/todo/todo_page.dart';
import 'package:jungle/view_model/set_theme/set_theme.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
part 'package:jungle/view/home/task/edit_task_bottom_sheet.dart/edit_task_bottom_sheet.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  TaskPageState createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage> {
  final taskBox = Hive.box<TaskModel>("task");

  @override
  Widget build(context) {
    final SetTheme setTheme = Provider.of<SetTheme>(context);
    setSystemTheme(setTheme);
    return Scaffold(
      backgroundColor: setTheme.setBackgroundTheme(),
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(setTheme),
      floatingActionButton: floatingActionButton(),
      drawer: buildDrawer(setTheme),
      body: buildBody(setTheme),
    );
  }

  /*---------- Widgets and Functions ----------*/

  AppBar buildAppBar(SetTheme setTheme) {
    return AppBar(
      // toolTip: "AppBar widget used in Task page"
      backgroundColor: setTheme.setBackgroundTheme(),
      title: Text(
        "Task",
        style: TextStyle(
          color: setTheme.setTextTheme(),
        ),
      ),
      elevation: 0.0,
      iconTheme: IconThemeData(color: setTheme.setTextTheme()),
    );
  }

  Widget buildDrawer(SetTheme setTheme) {
    return Drawer(
        backgroundColor: setTheme.setAppBarTheme(),
        child: Column(
          children: [
            const SizedBox(height: 34),
            Row(
              children: [
                const SizedBox(width: 20),
                Text("Jungle",
                    style: TextStyle(
                        color: setTheme.setTextTheme(),
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: MaterialButton(
                  // toolTip: "Task button used in the Drawer"
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  height: 50,
                  color: setTheme.setDrawerButtonTheme(),
                  elevation: 0.0,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: const Row(
                    children: [
                      SizedBox(width: 10),
                      Icon(Icons.event_note_outlined, color: Colors.teal),
                      SizedBox(width: 20),
                      Text(
                        "Task",
                        style: TextStyle(fontSize: 16, color: Colors.teal),
                      )
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: MaterialButton(
                  // toolTip: "Todo button used in the Drawer"
                  onPressed: () {
                    setTheme.showTaskPage = !setTheme.showTaskPage;
                    setTheme.saveStatus();
                    Get.off(()=> const TodoPage());
                  },
                  height: 50,
                  elevation: 0.0,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Icon(Icons.checklist_sharp,
                          color: setTheme.setTextTheme()),
                      const SizedBox(width: 20),
                      Text(
                        "Todo",
                        style: TextStyle(
                            color: setTheme.setTextTheme(), fontSize: 16),
                      )
                    ],
                  )),
            ),
            const SizedBox(height: 10),
            Divider(
              thickness: 1.0,
              color: Palette.ultramarineBlue,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: MaterialButton(
                  // toolTip: "Settings button used in the Drawer"
                  onPressed: () {
                    Get.toNamed("/settings");
                  },
                  height: 50,
                  elevation: 0.0,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Icon(
                        Icons.settings_outlined,
                        color: setTheme.setTextTheme(),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "Settings",
                        style: TextStyle(
                            color: setTheme.setTextTheme(), fontSize: 16),
                      )
                    ],
                  )),
            ),
          ],
        ));
  }

  Widget buildBody(SetTheme setTheme) {
    return ValueListenableBuilder(
        valueListenable: taskBox.listenable(),
        builder: (context, taskBox, _) {
          if (taskBox.isEmpty) {
            return showNoTask(setTheme);
          }
          return ListView.builder(
            itemCount: taskBox.length,
            itemBuilder: (context, int index) {
              index = taskBox.length - 1 - index;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                child: GestureDetector(
                  onLongPress: () {
                    deleteTaskOnLongPressDialog(
                        context, index, taskBox, setTheme);
                  },
                  child: GestureDetector(
                    onTap: () {
                      addTaskBottomSheet(context, setTheme, index);
                    },
                    child: Card(
                        color: setTheme.setAppBarTheme(),
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide()),
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
                                        color: setTheme.setTextTheme(),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 2.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Palette.ultramarineBlue),
                                        child: Text(
                                          taskBox.getAt(index)!.label,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 8.0),
                              child: Row(
                                children: [
                                  Text(
                                    taskBox.getAt(index)!.description,
                                    style: TextStyle(
                                        color: setTheme.setDescriptionTheme()),
                                    maxLines: 4,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    color: setTheme.setTextTheme(),
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    taskBox
                                        .getAt(index)!
                                        .currentDate
                                        .toString(),
                                    style: TextStyle(
                                        color: setTheme.setTextTheme()),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              );
            },
          );
        });
  }

  Widget showNoTask(SetTheme setTheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "asset/image/notes.png",
            width: 250,
          ),
          Text(
            "No task",
            style: TextStyle(fontSize: 17, color: setTheme.setTextTheme()),
          )
        ],
      ),
    );
  }

  FloatingActionButton floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Get.to(
          ()=> const AddNewTask(),
          transition: Transition.rightToLeft
          );
      },
      tooltip: "Add new task",
      backgroundColor: Palette.ultramarineBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: const Icon(
        Icons.add,
        size: 40,
      ),
    );
  }

  void deleteTaskOnLongPressDialog(BuildContext context, int index,
      Box<TaskModel> taskDB, SetTheme setTheme) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Deletion",
                style: TextStyle(color: setTheme.setTextTheme())),
            backgroundColor: setTheme.setBackgroundTheme(),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Text("Are you sure ?",
                style: TextStyle(color: setTheme.setTextTheme())),
            actions: [
              TextButton(
                onPressed: () {
                  taskDB.deleteAt(index);
                  Navigator.of(context).pop();
                },
                child: const Text("Yes"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red.shade600),
                ),
              )
            ],
          );
        });
  }

  /* This function changes status bar color and Navigation bar color */
  void setSystemTheme(SetTheme setTheme) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: setTheme.setBackgroundTheme(),
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ));
  }

}