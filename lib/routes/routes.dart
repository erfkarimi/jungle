import 'package:flutter/material.dart';
import 'package:jungle/view/settings/settings.dart';
import 'package:jungle/wrapper/wrapper.dart';
import '../view/home/home_page.dart';
import '../view/home/task_page/task_page.dart';
import '../view/settings/about_button/web_view_page/web_view_page.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/wrapper'        : (_)=> const Wrapper(),
  '/homePage'       : (_)=> const HomePage(),
  '/todoPage'       : (_)=> const TaskPage(),
  '/settings'       : (_)=> const Settings(),
  '/webView'        : (_)=> const WebViewPage(),
};