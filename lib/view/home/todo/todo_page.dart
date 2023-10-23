import 'package:flutter/material.dart';
import 'package:jungle/view/home/todo/done/done.dart';
import 'package:jungle/view_model/set_theme/set_theme.dart';
import 'package:provider/provider.dart';
import '../../../model/palette/palette.dart';
import 'undone/undone.dart';
import 'package:get/get.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  TodoPageState createState() => TodoPageState();
}

class TodoPageState extends State<TodoPage> {
  @override
  Widget build(context) {
    final SetTheme setTheme = Provider.of<SetTheme>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: setTheme.setBackgroundTheme(),
          resizeToAvoidBottomInset: false,
          appBar: buildAppBar(setTheme),
          drawer: buildDrawer(setTheme),
          body: const TabBarView(
            children: [Undone(), Done()],
          )),
    );
  }

  AppBar buildAppBar(SetTheme setTheme) {
    return AppBar(
        backgroundColor: setTheme.setBackgroundTheme(),
        elevation: 0.0,
        iconTheme: IconThemeData(color: setTheme.setTextTheme()),
        title: Text(
          "Todo",
          style: TextStyle(color: setTheme.setTextTheme()),
        ),
        bottom: TabBar(
            indicatorWeight: 3.0,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: setTheme.setTextTheme(),
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.checklist,
                      color: setTheme.setTextTheme(),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Undone",
                      style: TextStyle(
                      color: setTheme.setTextTheme()
                    )
                      )
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check,
                      color: setTheme.setTextTheme(),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Done",
                      style: TextStyle(
                        color: setTheme.setTextTheme()
                      )
                      )
                  ],
                ),
              )
            ]));
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
                  onPressed: () {
                    setTheme.showTaskPage = !setTheme.showTaskPage;
                    setTheme.saveStatus();
                    Get.offNamed('/taskPage');
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
                        Icons.event_note_outlined,
                        color: setTheme.setTextTheme(),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "Task",
                        style: TextStyle(
                          fontSize: 16,
                          color: setTheme.setTextTheme(),
                        ),
                      )
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  height: 50,
                  elevation: 0.0,
                  color: setTheme.setDrawerButtonTheme(),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: const Row(
                    children: [
                      SizedBox(width: 10),
                      Icon(Icons.checklist_sharp, color: Colors.teal),
                      SizedBox(width: 20),
                      Text(
                        "Todo",
                        style: TextStyle(color: Colors.teal, fontSize: 16),
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
                          fontSize: 16,
                          color: setTheme.setTextTheme(),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ));
  }
}