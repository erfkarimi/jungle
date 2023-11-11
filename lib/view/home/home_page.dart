import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jungle/view/home/task/task_page.dart';
import 'package:jungle/view_model/app_ui_style/app_ui_style.dart';
import 'completed_todo_page/completed_todo_page.dart';
import 'todo_page/todo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final Box settingsBox = Hive.box("settings");
  @override
  Widget build(context) {
    
    return SafeArea(
      top: false,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: buildAppBar(),
          body: buildBody(),
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: AppBar(
        leading: null,
        elevation: 0.0,
        title: const Text(
          "Jungle",
          style: TextStyle(
              fontWeight: FontWeight.bold),
        ),
        actions: appBarActionWidget(),
        bottom: tabBarWidget(),
      ),
    );
  }

  List<Widget> appBarActionWidget() {
    final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context);
    return [
      MaterialButton(
        minWidth: 10,
        onPressed: (){
          setState(() {
          appUiStyle.darkTheme = !appUiStyle.darkTheme;
          appUiStyle.saveToDb(appUiStyle.darkTheme);
        });
        },
        shape: CircleBorder(
          side: BorderSide(color: appUiStyle.setTextTheme()),
        ),
        child: Icon(
          appUiStyle.darkTheme ? Icons.wb_sunny_outlined
          : Icons.brightness_2_outlined,
          color: appUiStyle.setTextTheme())
      ),
      MaterialButton(
        minWidth: 10,
        onPressed: () => Get.toNamed("/notifications"),
        shape: CircleBorder(
          side: BorderSide(color: appUiStyle.setTextTheme()),
        ),
        child: Icon(
          Icons.notifications_outlined,
          color: appUiStyle.setTextTheme()
          ),
      ),
      MaterialButton(
        minWidth: 10,
        onPressed: () => Get.toNamed("/settings"),
        shape: CircleBorder(
          side: BorderSide(
            color: appUiStyle.setTextTheme()),
        ),
        child: Icon(
          Icons.settings_outlined,
          color: appUiStyle.setTextTheme()),
      ),
    ];
  }

  PreferredSizeWidget tabBarWidget() {
    return TabBar(
        indicatorPadding:
            const EdgeInsets.symmetric(vertical: 5),
        splashBorderRadius: BorderRadius.circular(10),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold),
        tabs: tabListWidget());
  }

  List<Tab> tabListWidget() {
    return [
      const Tab(child: Text("My Task")),
      const Tab(child:Text("My Todo")),
      const Tab(child: Text("Completed")),
    ];
  }

  Widget buildBody() {
    return const TabBarView(
        children: [TaskPage(), TodoPage(), CompletedTodo()]);
  }
}
