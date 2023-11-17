import 'package:flutter/material.dart';
import 'package:jungle/view/settings/settings.dart';
import 'package:jungle/view/splash_screen/splash_screen.dart';
import '../view/home/home_page.dart';
import '../view/home/notifications_page/notifications_page.dart';
import '../view/home/todo_page/todo_page.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/splashScreen'   : (_)=> const SplashScreen(),
  '/homePage'       : (_)=> const HomePage(),
  '/todoPage'       : (_)=> const TodoPage(),
  '/settings'       : (_)=> const Settings(),
  '/notifications'  : (_)=> const NotificationsPage() 
};