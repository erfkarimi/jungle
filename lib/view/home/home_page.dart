import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jungle/view/home/task/task_page.dart';
import 'package:jungle/view_model/db_counter_state/db_counter_state.dart';
import 'package:jungle/view_model/set_theme/set_theme.dart';
import 'package:provider/provider.dart';
import '../../model/palette/palette.dart';
import 'completed/completed.dart';
import 'todo_page/todo_page.dart';

class HomePage extends StatefulWidget {
  final Function? notifyParent;
  const HomePage({Key? key, this.notifyParent}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(context) {
    final SetTheme setTheme = Provider.of<SetTheme>(context);
    return SafeArea(
      top: false,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: setTheme.setBackgroundTheme(),
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ),
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: buildAppBar(setTheme),
            body: buildBody(),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar(SetTheme setTheme) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: AppBar(
        backgroundColor: setTheme.setAppBarTheme(),
        elevation: 0.0,
        title: Text(
          "Jungle",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: setTheme.setTextTheme()),
        ),
        actions: appBarActionWidget(setTheme),
        bottom: tabBarWidget(setTheme),
      ),
    );
  }

  List<Widget> appBarActionWidget(SetTheme setTheme) {
    final welcomePageDB = Hive.box("welcome");
    return [
      MaterialButton(
        minWidth: 10,
        onPressed: () => welcomePageDB.put("welcomePage", false),
        shape: CircleBorder(
          side: BorderSide(color: setTheme.setTextTheme()),
        ),
        child: const Icon(Icons.notifications_outlined),
      ),
      MaterialButton(
        minWidth: 10,
        onPressed: () => Get.toNamed("/settings"),
        shape: CircleBorder(
          side: BorderSide(color: setTheme.setTextTheme()),
        ),
        child: const Icon(Icons.settings_outlined),
      ),
    ];
  }

  PreferredSizeWidget tabBarWidget(SetTheme setTheme) {
    return TabBar(
        dividerColor: Colors.transparent,
        indicatorWeight: 1.0,
        indicatorPadding:
            const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        indicatorSize: TabBarIndicatorSize.tab,
        splashBorderRadius: BorderRadius.circular(50),
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Palette.ultramarineBlue),
        tabs: tabListWidget(setTheme));
  }

  List<Tab> tabListWidget(SetTheme setTheme) {
    final DbCounterState dbCounterState = Provider.of<DbCounterState>(context);
    return [
      Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Task", style: TextStyle(color: setTheme.setTextTheme())),
            const SizedBox(width: 5.0),
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: Colors.green.shade200, shape: BoxShape.circle),
              child: Center(
                child: Text("${dbCounterState.taskCounter}",
                    style: TextStyle(color: setTheme.setTextTheme())),
              ),
            ),
          ],
        ),
      ),
      Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Todo", style: TextStyle(color: setTheme.setTextTheme())),
            const SizedBox(width: 5.0),
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: Colors.green.shade200, shape: BoxShape.circle),
              child: Center(
                child: Text("${dbCounterState.todoCounter}",
                    style: TextStyle(color: setTheme.setTextTheme())),
              ),
            )
          ],
        ),
      ),
      Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Completed", style: TextStyle(color: setTheme.setTextTheme())),
            const SizedBox(width: 5.0),
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: Colors.green.shade200, shape: BoxShape.circle),
              child: Center(
                child: Text("${dbCounterState.completedCounter}",
                    style: TextStyle(color: setTheme.setTextTheme())),
              ),
            )
          ],
        ),
      ),
    ];
  }

  Widget buildBody() {
    return const TabBarView(
        children: [TaskPage(), TodoPage(), CompletedTodo()]);
  }
}
