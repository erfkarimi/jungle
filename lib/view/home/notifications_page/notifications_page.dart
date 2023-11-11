import 'package:flutter/material.dart';
import 'package:jungle/view_model/app_ui_style/app_ui_style.dart';
import 'package:jungle/widget/leading_button_widget/leading_button_widget.dart';
class NotificationsPage extends StatelessWidget{
  const NotificationsPage({super.key});

  @override 
  Widget build(context){
    final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context);
    return Scaffold(
      appBar: buildAppBar(appUiStyle),
      body:  buildBody(),
    );
  }

  AppBar buildAppBar(AppUiStyle appUiStyle){
    return AppBar(
      title: const Text(
        "Notifications",
      ),
      leading: LeadingButtonWidget(appUiStyle: appUiStyle),
    );
  }

  Widget buildBody(){
    return showNoNotifications();
  }

    Widget showNoNotifications() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "asset/image/new-notifications-amico.png",
            width: 250,
          ),
          const Text(
            "No notifications",
            style: TextStyle(
              fontSize: 17,),
          )
        ],
      ),
    );
  }
}