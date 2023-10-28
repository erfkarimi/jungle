import 'package:flutter/material.dart';
import 'package:jungle/view/home/task/create_task_page/create_task_page.dart';
import 'package:jungle/view/home/task/task_page.dart';
import 'package:jungle/view/settings/settings.dart';
import 'package:jungle/view/splash_screen/splash_screen.dart';
import 'package:jungle/view/welcome_page/first_welcome_page/first_welcome_page.dart';
import 'package:jungle/view/welcome_page/second_welcome_page/second_welcome_page.dart';
import 'package:jungle/view/welcome_page/third_welcome_page/third_welcome_page.dart';
import 'package:jungle/view/welcome_page/welcome_page.dart';
import '../view/home/home_page.dart';
import '../view/home/notifications_page/notifications_page.dart';
import '../view/home/todo_page/todo_page.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/splashScreen'   : (_)=> const SplashScreen(),
  '/welcomePage'    : (_)=> const WelcomePage(),
  '/firstWelcome'   : (_)=> const FirstWelcomePage(),
  '/secondWelcome'  : (_)=> const SecondWelcomePage(),
  '/thirdWelcome'   : (_)=> const ThirdWelcomePage(),
  '/homePage'       : (_)=> const HomePage(),
  '/todoPage'       : (_)=> const TodoPage(),
  '/taskPage'       : (_)=> const TaskPage(),
  '/addNewTask'     : (_)=> const CreateTaskPage(),
  '/settings'       : (_)=> const Settings(),
  '/notifications'  : (_)=> const NotificationsPage() 
};