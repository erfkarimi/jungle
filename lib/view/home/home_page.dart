import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jungle/constant/palette/palette.dart';
import 'package:jungle/view/service/notification_service/notification_service.dart';
import 'completed_todo_page/completed_todo_page.dart';
import 'todo_page/todo_page.dart';

part 'notification_perm_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final Box settingsBox = Hive.box("settings");
  @override
  void initState() {
    super.initState();
    notificationPermissionFunc(context);
    NotificationService().notificationInitialization();
  }

  @override
  Widget build(context) {
    return SafeArea(
      top: false,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: Theme.of(context).colorScheme.background,
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
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: appBarActionWidget(),
      bottom: tabBarWidget(),
    );
  }

  List<Widget> appBarActionWidget() {
    return [
      MaterialButton(
        minWidth: 10,
        onPressed: () => Get.toNamed("/settings"),
        child: const Icon(
          Icons.settings_outlined,
        ),
      ),
    ];
  }

  TabBar tabBarWidget() {
    return TabBar(
        tabAlignment: TabAlignment.start,
        dividerColor: Theme.of(context).colorScheme.background,
        isScrollable: true,
        indicatorPadding: const EdgeInsets.symmetric(vertical: 5),
        splashBorderRadius: BorderRadius.circular(10),
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        tabs: tabListWidget());
  }

  List<Tab> tabListWidget() {
    return [
      const Tab(child: Text("My task")),
      const Tab(child: Text("Completed")),
    ];
  }

  Widget buildBody() {
    return const TabBarView(children: [TodoPage(), CompletedTodo()]);
  }
}
