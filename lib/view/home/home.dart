import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jungle/model/palette/palette.dart';
import 'package:jungle/model/task_model/task_model.dart';
import 'package:jungle/view/add_task/add_task.dart';
import 'package:jungle/view/settings/settings.dart';
import 'package:jungle/view_model/set_theme/set_theme.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
part 'edit_task_bottom_sheet.dart/edit_task_bottom_sheet.dart';

class Home extends StatefulWidget{
  const Home({super.key});

  @override 
  HomeState createState()=> HomeState();
}
class HomeState extends State<Home>{
  final taskBox = Hive.box<TaskModel>("task");

  @override
  Widget build(context){
    final SetTheme setTheme = Provider.of<SetTheme>(context);
    setSystemTheme(setTheme);
    return Scaffold(
      backgroundColor: setTheme.setBackgroundTheme(),
      appBar: buildAppBar(setTheme),
      floatingActionButton: floatingActionButton(),
      body: buildBody(setTheme),

    );
  }

  /*---------- Widgets and Functions ----------*/

  /* App Bar */
  AppBar buildAppBar(SetTheme setTheme){
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: setTheme.setAppBarTheme(),
      title: Text(
        "Home",
        style: TextStyle(
          color: setTheme.setTextTheme(),

        ),
      ),
      elevation: 0.0,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: MaterialButton(
            onPressed: (){
              Navigator.of(context).push(
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: const Settings()
                )
              );
            },
            minWidth: 20,
            shape: CircleBorder(
              side: BorderSide(
                color: setTheme.setTextTheme()
              )
            ),
            child: Icon(
            Icons.settings_outlined,
            color: setTheme.setTextTheme(),
            ),
          ),
        ),
      ],
    );
  }


  Widget buildBody(SetTheme setTheme){
    return ValueListenableBuilder(
      valueListenable: taskBox.listenable(),
      builder: (context, taskBox, child){
        if(taskBox.isEmpty){
          return showNoTask(setTheme);
        }
        return ListView.builder(
          itemCount: taskBox.length,
          itemBuilder: (context, int index){
            index = taskBox.length - 1 - index;
            return Padding(
              padding: const EdgeInsets.all(4),
              child: Card(
                color: setTheme.setAppBarTheme(),
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide()
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            taskBox.getAt(index)!.title,
                            style: TextStyle(
                            color: setTheme.setTextTheme(),
                            fontWeight: FontWeight.bold,
                            fontSize: 16                
                              ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2.0
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Palette.ultramarineBlue
                                ),
                                child: Text(
                                  taskBox.getAt(index)!.label,
                                  style: const TextStyle(
                                    color: Colors.white
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: (){
                                  addTaskBottomSheet(
                                    context,
                                    setTheme,
                                    index
                                    );
                                },
                                icon: Icon(
                                  Icons.more_horiz,
                                  color: setTheme.setTextTheme(),
                                  ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0, bottom: 8.0
                      ),
                      child: Row(
                        children: [
                          Text(
                                taskBox.getAt(index)!.description,
                                style: TextStyle(
                                    color:
                                        setTheme.setDescriptionTheme()),
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
                            taskBox.getAt(index)!.currentDate.toString(),
                            style: TextStyle(
                              color: setTheme.setTextTheme()
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ),
            );
          },
        );
      }
      );
  }

  Widget showNoTask(SetTheme setTheme){
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
            style: TextStyle(
              fontSize: 17,
              color: setTheme.setTextTheme()
            ),
          )
        ],
      ),
    );
  }

  FloatingActionButton floatingActionButton(){
      return FloatingActionButton(
        onPressed: (){
         Navigator.of(context).push(
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: const AddNewTask()
            )
         );
        },
        tooltip: "Add new task",
        backgroundColor: Palette.ultramarineBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child: const Icon(
          Icons.add,
          size: 40,
          ),
        );
  }
  
  /* This function changes status bar color and Navigation bar color */
  void setSystemTheme(SetTheme setTheme){
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: setTheme.setBackgroundTheme(),
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ));
  }

}