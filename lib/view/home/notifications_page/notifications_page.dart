import 'package:flutter/material.dart';
import 'package:jungle/view_model/app_ui_style/app_ui_style.dart';
import 'package:jungle/widget/leading_button_widget/leading_button_widget.dart';

class NotificationsPage extends StatelessWidget{
  const NotificationsPage({super.key});

  @override 
  Widget build(context){
    final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context);
    return Scaffold(
      backgroundColor: appUiStyle.setAppBarTheme(),
      appBar: buildAppBar(appUiStyle),
      body:  buildBody(appUiStyle),
    );
  }

  AppBar buildAppBar(AppUiStyle appUiStyle){
    return AppBar(
      backgroundColor: appUiStyle.setAppBarTheme(),
      title: Text(
        "Notifications",
        style: TextStyle(
          fontFamily: appUiStyle.font,
          color: appUiStyle.setTextTheme()
        ),
      ),
      leading: LeadingButtonWidget(appUiStyle: appUiStyle),
    );
  }

  Widget buildBody(AppUiStyle appUiStyle){
    return showNoNotifications(appUiStyle);
  }

    Widget showNoNotifications(AppUiStyle appUiStyle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "asset/image/new-notifications-amico.png",
            width: 250,
          ),
          Text(
            "No notifications",
            style: TextStyle(
              fontFamily: appUiStyle.font,
              fontSize: 17, color: appUiStyle.setTextTheme()),
          )
        ],
      ),
    );
  }
}