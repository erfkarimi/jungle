import 'package:flutter/material.dart';
import 'package:jungle/view/add_task/add_task.dart';
import 'package:jungle/view/home/home.dart';
import 'package:jungle/view/home/task/task_page.dart';
import 'package:jungle/view/home/todo/todo_page.dart';
import 'package:jungle/view/settings/settings.dart';
import 'package:jungle/view/splash_screen/splash_screen.dart';
import 'package:jungle/view/welcome_page/page_1/page_1.dart';
import 'package:jungle/view/welcome_page/page_2/page_2.dart';
import 'package:jungle/view/welcome_page/page_3/page_3.dart';
import 'package:jungle/view/welcome_page/welcome_page.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/splashScreen' : (_)=> const SplashScreen(),
  '/welcomePage'  : (_)=> const WelcomePage(),
  '/page1'        : (_)=> const Page1(),
  '/page2'        : (_)=> const Page2(),
  '/page3'        : (_)=> const Page3(),
  '/home'         : (_)=> const Home(),
  '/todoPage'     : (_)=> const TodoPage(),
  '/taskPage'     : (_)=> const TaskPage(),
  '/addNewTask'   : (_)=> const AddNewTask(),
  '/settings'   : (_)=> const Settings()
};