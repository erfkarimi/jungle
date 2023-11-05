import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jungle/model/palette/palette.dart';
import 'package:jungle/view/home/task/task_page.dart';
import 'package:jungle/view_model/db_counter_state/db_counter_state.dart';
import 'package:jungle/view_model/app_ui_style/app_ui_style.dart';
import 'completed_todo_page/completed_todo_page.dart';
import 'todo_page/todo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(context) {
    final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context);
    return SafeArea(
      top: false,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: appUiStyle.setBackgroundTheme(),
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ),
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: buildAppBar(appUiStyle),
            body: buildBody(),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar(AppUiStyle appUiStyle) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: AppBar(
        backgroundColor: appUiStyle.setAppBarTheme(),
        leading: null,
        elevation: 0.0,
        title: Text(
          "Jungle",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: appUiStyle.font,
              color: appUiStyle.setTextTheme()),
        ),
        actions: appBarActionWidget(appUiStyle),
        bottom: tabBarWidget(appUiStyle),
      ),
    );
  }

  List<Widget> appBarActionWidget(AppUiStyle appUiStyle) {
    final Box welcomePageDB = Hive.box("welcome");
    return [
      MaterialButton(
        minWidth: 10,
        onPressed: () => welcomePageDB.put("welcomePage", false),
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

  PreferredSizeWidget tabBarWidget(AppUiStyle appUiStyle) {
    return TabBar(
        dividerColor: appUiStyle.setAppBarTheme(),
        indicatorPadding:
            const EdgeInsets.symmetric(vertical: 5),
        indicatorSize: TabBarIndicatorSize.label,
        splashBorderRadius: BorderRadius.circular(10),
        labelColor: Palette.ultramarineBlue,
        unselectedLabelColor: appUiStyle.setTextTheme(),
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: appUiStyle.font),
        tabs: tabListWidget());
  }

  List<Tab> tabListWidget() {
    final DbCounterState dbCounterState = Provider.of<DbCounterState>(context);
    return [
      Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Task",),
            const SizedBox(width: 5.0),
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text("${dbCounterState.taskCounter}",
                    style: const TextStyle(color: Colors.black)),
              ),
            )
          ],
        ),
      ),
      Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Todo"),
            const SizedBox(width: 5.0),
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text("${dbCounterState.todoCounter}",
                    style: const TextStyle(color: Colors.black)),
              ),
            )
          ],
        ),
      ),
      Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Completed",),
            const SizedBox(width: 5.0),
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text("${dbCounterState.completedCounter}",
                    style: const TextStyle(color: Colors.black)),
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
