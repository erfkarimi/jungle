import 'package:flutter/material.dart';
import 'package:jungle/view/settings/theme_button/theme_button.dart';
import 'package:jungle/widget/leading_button_widget/leading_button_widget.dart';
import '../../view_model/app_ui_style/app_ui_style.dart';
import 'feedback_button/feedback_button.dart';

class Settings extends StatelessWidget{
  const Settings({super.key});
  
  @override 
  Widget build(context){
    final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context);
    return Scaffold(
      appBar: buildAppBar(context, appUiStyle),
      body: buildBody(context, appUiStyle)
    );
  }

  AppBar buildAppBar(BuildContext context, AppUiStyle appUiStyle){
    return AppBar(
      elevation: 0.0,
      title: const Text(
        "Settings",
      ),
      leading: LeadingButtonWidget(appUiStyle: appUiStyle)
    );
  }

  Widget buildBody(BuildContext context, AppUiStyle appUiStyle){
    return Column(
      children: [
        const ThemeButton(),
        FeedbackButton(appUiStyle: appUiStyle)
      ],
    );
  }
}