import 'package:flutter/material.dart';
import 'package:jungle/view/home/task/task_page.dart';
import 'package:jungle/view/home/todo/todo_page.dart';
import 'package:jungle/view_model/set_theme/set_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget{
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home>{
  @override
  void initState() {
    super.initState();
    init(context);
  }
  
  @override 
  Widget build(context){
    final setTheme = Provider.of<SetTheme>(context);
    if(setTheme.showTaskPage == true){
      return const TaskPage();
    } else {
      return const TodoPage();
    }
  }

  Future<void> init(context) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final setTheme = Provider.of<SetTheme>(context, listen: false);
    setState(() {
      setTheme.showTaskPage = preferences.getBool("showTaskPage") ?? true;
    });
  }
}