import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:jungle/view/home/task/task_page.dart';
import 'package:jungle/view_model/db_counter_state/db_counter_state.dart';
import 'package:jungle/view_model/set_theme/set_theme.dart';
import 'package:provider/provider.dart';
import '../../model/palette/palette.dart';
import '../../model/task_model/task_model.dart';
import '../../model/todo_model/todo_model.dart';
import 'completed/completed.dart';
import 'todo_page/todo_page.dart';

class  HomePage extends StatefulWidget{
  final Function? notifyParent;
  const HomePage({Key? key, this.notifyParent}): super(key: key);

  @override 
  HomePageState createState()=> HomePageState();
}

class HomePageState extends State<HomePage>{
  @override 
  Widget build(context){
    final SetTheme setTheme = Provider.of<SetTheme>(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: setTheme.setBackgroundTheme(),
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          appBar: buildAppBar(setTheme),
          body: buildBody(),
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar(SetTheme setTheme){
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          "Jungle",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        actions: appBarActionWidget(),
        bottom: tabBarWidget(setTheme),
      ),
    );
  }

  List<Widget> appBarActionWidget(){
    return [
      IconButton(
        onPressed: (){},
        icon: const Icon(Icons.notifications_outlined)
        ),
      IconButton(
        onPressed: (){},
        icon: const Icon(Icons.settings_outlined)
        ),
    ];
  }

  PreferredSizeWidget tabBarWidget(SetTheme setTheme){
    
    return TabBar(
          dividerColor: Colors.transparent,
          indicatorWeight: 1.0,
          indicatorPadding: const EdgeInsets.symmetric(
            vertical: 7, horizontal: 10),
          indicatorSize: TabBarIndicatorSize.tab,
          splashBorderRadius: BorderRadius.circular(50),
          padding: const EdgeInsets.symmetric(
            horizontal: 10),
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold),
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Palette.ultramarineBlue),
          tabs: tabListWidget(setTheme)
          );
  }

  List<Tab> tabListWidget(SetTheme setTheme) {
    final Box taskBox = Hive.box<TaskModel>("task");
    final Box todoBox = Hive.box<TodoModel>("todo");
    final Box completedBox = Hive.box<TodoModel>("completed");
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
                child:
                  Consumer<DbCounterState>(
                    builder: (context, dbCounterState, _){
                      return Text("${dbCounterState.taskCounter}",
                        style: TextStyle(color: setTheme.setTextTheme()));
                    },
                  ),
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
                child: Text("${todoBox.length}",
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
                child: Text("${completedBox.length}",
                    style: TextStyle(color: setTheme.setTextTheme())),
              ),
            )
          ],
        ),
      ),
    ];
  }

  Widget buildBody(){
    return const TabBarView(
      children: [
        TaskPage(),
        TodoPage(),
        CompletedTodo()
      ]
      );
  }
}