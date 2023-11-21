import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jungle/constant/palette/palette.dart';
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
  void initState() {
    super.initState();
    notificationPermissionFunc();
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
          style: TextStyle(
              fontWeight: FontWeight.bold),
        ),
        actions: appBarActionWidget(),
        bottom: tabBarWidget(),
    );
  }

  List<Widget> appBarActionWidget() {
    return [
      MaterialButton(
        minWidth: 10,
        onPressed: () => Get.toNamed("/notifications"),
        child: const Icon(
          Icons.notifications_outlined,
          ),
      ),
      MaterialButton(
        minWidth: 10,
        onPressed: () => Get.toNamed("/settings"),
        child: const Icon(
          Icons.settings_outlined,
          ),
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

  void notificationPermissionFunc(){
    AwesomeNotifications().isNotificationAllowed()
    .then((isAllowed){
      if(!isAllowed){
        showDialog(
      context: context,
      builder: (context)=> AlertDialog(
        title: const Text("Allow notifications"),
        content: const Text("Our app would like to send you notifications"),
        actions: [
          TextButton(
            onPressed: ()=> Navigator.pop(context),
            child: const Text(
              'Don\'t allow',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18
              ),
            )
            ),
          TextButton(
            onPressed: (){
              AwesomeNotifications()
                .requestPermissionToSendNotifications()
                .then((_){
                    Navigator.pop(context);
                });
            },
            child: Text(
              'Allow',
              style: TextStyle(
                fontSize: 18,
                color: Palette.ultramarineBlue,
                fontWeight: FontWeight.bold
              ),
            )
            )
        ],
      )
      );
      }
    } );
  }
}
