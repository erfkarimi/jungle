import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:jungle/model/palette/palette.dart';
import 'package:jungle/model_view/change_theme/theme.dart';
import 'package:jungle/view/home/add_task_bottom_sheet/bottom_sheet.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget{
  const Home({super.key});

  @override 
  HomeState createState()=> HomeState();
}

class HomeState extends State<Home>{
  @override
  Widget build(context){
    final ChangeTheme changeTheme = Provider.of<ChangeTheme>(context);
    setTheme(changeTheme);
    return Scaffold(
      backgroundColor: changeTheme.changeBackgroundTheme(),
      appBar: buildAppBar(changeTheme),
      floatingActionButton: addTaskFloatingActionButton(),
      body: buildBody(),

    );
  }

  /*---------- Widgets and Functions ----------*/

  /* App Bar */
  AppBar buildAppBar(ChangeTheme changeTheme){
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: changeTheme.changeAppBarTheme(),
      title: Text(
        "Home",
        style: TextStyle(
          color: changeTheme.changeTextTheme()
        ),
      ),
      elevation: 0.0,
      actions: [
        IconButton(
          onPressed: (){
            settingsBottomSheet(context, changeTheme);
          },
          icon: Icon(
            Icons.settings_outlined,
            color: changeTheme.changeTextTheme(),
            ),
        )
      ],
    );
  }

  Widget buildBody(){
    return showNoTask();
  }

  Widget showNoTask(){
    final ChangeTheme changeTheme = Provider.of<ChangeTheme>(context);
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
              color: changeTheme.changeTextTheme()
            ),
          )
        ],
      ),
    );
  }

  /* Floating button */
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

  void settingsBottomSheet(context, ChangeTheme changeTheme){
    showModalBottomSheet(
      context: context, 
      builder: (context){
        return BottomSheet(
          onClosing: (){},
          backgroundColor: changeTheme.changeBackgroundTheme(),
          enableDrag: false,
          builder: (context){
            return SizedBox(
              height: 227,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Container(
                      height: 4,
                      width: 100,
                      decoration: BoxDecoration(
                        color: changeTheme.changeTextTheme(),
                        borderRadius: BorderRadius.circular(20)
                      ),
                    ),
                    const SizedBox(height: 20),
                    languageButton(changeTheme),
                    themeButton(changeTheme),
                    feedbackButton(changeTheme)
                  ],
                ),
              )
            );
          }
          );
      }
    );
  }


  Widget languageButton(ChangeTheme changeTheme){
    return MaterialButton(
      onPressed: (){},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: ListTile(
        leading: Icon(
          Icons.translate,
          color: changeTheme.changeTextTheme()
          ),
          title: Text(
            "Language",
            style: TextStyle(
              color: changeTheme.changeTextTheme()
            ),
            ),
      )
    );
  }


  Widget themeButton(ChangeTheme changeTheme){
    return MaterialButton(
      onPressed: (){
        Navigator.of(context).pop();
        showThemeDialog(changeTheme);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: ListTile(
        leading: Icon(
          Icons.brightness_2_outlined,
          color: changeTheme.changeTextTheme(),
          ),
          title: Text(
            "Theme",
            style: TextStyle(
              color: changeTheme.changeTextTheme(),
            ),
            ),
      )
    );
  }


  Widget feedbackButton(ChangeTheme changeTheme){
    return MaterialButton(
      onPressed: (){},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: ListTile(
        leading: Icon(
          Icons.question_mark,
          color: changeTheme.changeTextTheme(),
          ),
          title: Text(
            "feedback",
            style: TextStyle(
              color: changeTheme.changeTextTheme()
            ),
            ),
      )
    );
  }


  void showThemeDialog(ChangeTheme changeTheme){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          backgroundColor: changeTheme.changeBackgroundTheme(),
          title: Text(
            "Theme",
            style: TextStyle(
              color: changeTheme.changeTextTheme()
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              lightThemeButton(),
              darkThemeButton()
            ],
          ),
        );
      }
    );
  }

  Widget lightThemeButton(){
    final ChangeTheme changeTheme = Provider.of<ChangeTheme>(context);
    return MaterialButton(
      minWidth: double.infinity,
      onPressed: (){
        changeTheme.theme = "light";
        changeTheme.saveChangeTheme();
        Navigator.of(context).pop();
      },
      color: Palette.copenhagenBlue,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        "Light",
        style: TextStyle(
          fontSize: 17,
          color: Colors.black
        ),
      ),
    );
  }


  Widget darkThemeButton(){
    final ChangeTheme changeTheme = Provider.of<ChangeTheme>(context);
    return MaterialButton(
      minWidth: double.infinity,
      onPressed: (){
        changeTheme.theme = "dark";
        changeTheme.saveChangeTheme();
        Navigator.of(context).pop();
      },
      elevation: 0.0,
      color: Palette.copenhagenBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        "Dark",
        style: TextStyle(
          fontSize: 17,
          color: Colors.black
        ),
      ),
    );
  }



  void setTheme(ChangeTheme changeTheme){
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: changeTheme.changeBackgroundTheme(),
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ));
  }
}