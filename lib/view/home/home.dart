import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jungle/model/palette/palette.dart';
import 'package:jungle/view/home/add_task_bottom_sheet/bottom_sheet.dart';

class Home extends StatefulWidget{
  const Home({super.key});

  @override 
  HomeState createState()=> HomeState();
}

class HomeState extends State<Home>{
  @override
  Widget build(context){
    return Scaffold(
      appBar: buildAppBar(),
      floatingActionButton: addTaskFloatingActionButton(),
      body: buildBody(),

    );
  }

                      /*---------- Widgets and Functions ----------*/
  AppBar buildAppBar(){
    setTheme();
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text(
        "Home"
      ),
      elevation: 0.0,
      actions: [
        IconButton(
          onPressed: (){},
          icon: const Icon(Icons.settings_outlined),
        )
      ],
    );
  }

  Widget buildBody(){
    return showNoTask();
  }

  Widget showNoTask(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "asset/image/notes.png",
            width: 250,
          ),
          const Text(
            "No task",
            style: TextStyle(
              fontSize: 17
            ),
          )
        ],
      ),
    );
  }

  FloatingActionButton addTaskFloatingActionButton(){
    return FloatingActionButton.extended(
      onPressed: (){
        addTaskBottomSheet(context);
      },
      backgroundColor: Palette.copenhagenBlue,
      icon: const Icon(Icons.edit),
      label: const Text(
        "New task"
      ),
    );
  }

  void addTaskBottomSheet(context){
    showModalBottomSheet(
      context: context, 
      isDismissible: false,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context){
        return const AddTaskBottomSheet();
      }
    );
  }



  void setTheme(){
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ));
  }
}