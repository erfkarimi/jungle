import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
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
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: Theme.of(context).colorScheme.background
        ),
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: buildAppBar(),
            body: buildBody(),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        leading: null,
        elevation: 0.0,
        title: const Text(
          "Jungle",
          style: TextStyle(
              fontWeight: FontWeight.bold),
        ),
        actions: appBarActionWidget(),
        bottom: tabBarWidget(),
    );
  }

  List<Widget> appBarActionWidget() {
    final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context);
    return [
      MaterialButton(
        minWidth: 10,
        onPressed: () => Get.toNamed("/notifications"),
        child: Icon(
          Icons.notifications_outlined,
          color: appUiStyle.setTextTheme()
          ),
      ),
      MaterialButton(
        minWidth: 10,
        onPressed: () => Get.toNamed("/settings"),
        child: Icon(
          Icons.settings_outlined,
          color: appUiStyle.setTextTheme()),
      ),
    ];
  }

  PreferredSize tabBarWidget() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: TabBar(
          dividerColor: Theme.of(context).colorScheme.background,
          isScrollable: true,
            indicatorPadding:
                const EdgeInsets.symmetric(vertical: 5),
            splashBorderRadius: BorderRadius.circular(10),
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold),
            tabs: tabListWidget()),
      ),
    );
  }

  List<Tab> tabListWidget() {
    return [
      const Tab(child: Text("My task")),
      const Tab(child: Text("Completed")),
    ];
  }

  Widget buildBody() {
    return const TabBarView(
        children: [TodoPage(), CompletedTodo()]);
  }
}
