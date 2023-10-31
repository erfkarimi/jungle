import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../view_model/app_ui_style/app_ui_style.dart';

class Settings extends StatelessWidget{
  const Settings({super.key});
  
  @override 
  Widget build(context){
    final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: appUiStyle.setAppBarTheme()
      ),
      child: Scaffold(
        backgroundColor: appUiStyle.setAppBarTheme(),
        appBar: buildAppBar(context, appUiStyle),
        body: buildBody(context, appUiStyle)
      ),
    );
  }

  AppBar buildAppBar(BuildContext context, AppUiStyle appUiStyle){
    return AppBar(
      backgroundColor: appUiStyle.setAppBarTheme(),
      elevation: 0.0,
      title: Text(
        "Settings",
        style: TextStyle(
          color: appUiStyle.setTextTheme(),
        ),
      ),
      leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: MaterialButton(
            onPressed: (){
              Get.back();
            },
            minWidth: 10,
            shape: CircleBorder(
              side: BorderSide(
                color: appUiStyle.setTextTheme()
              )
            ),
            child: Icon(
            Icons.arrow_back,
            color: appUiStyle.setTextTheme()
            ),
          ),
        ),
    );
  }

  Widget buildBody(BuildContext context, AppUiStyle appUiStyle){
    return Column(
      children: [
        themeButton(context, appUiStyle),
        feedbackButton(context, appUiStyle)
      ],
    );
  }


  Widget themeButton(BuildContext context, AppUiStyle appUiStyle){
    return MaterialButton(
      onPressed: (){
        showThemeDialog(context, appUiStyle);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: ListTile(
        leading: Icon(
          Icons.brightness_2_outlined,
          color: appUiStyle.setTextTheme(),
          ),
          title: Text(
             "Theme",
            style: TextStyle(
              color: appUiStyle.setTextTheme(),
            ),
            ),
      )
    );
  }


  Widget feedbackButton(BuildContext context, AppUiStyle appUiStyle){
    return MaterialButton(
      onPressed: (){
        _sendMail();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: ListTile(
        leading: Icon(
          Icons.question_mark,
          color: appUiStyle.setTextTheme(),
          ),
          title: Text(
            "Feedback",
            style: TextStyle(
              color: appUiStyle.setTextTheme()
            ),
            ),
      )
    );
  }

  void showThemeDialog(BuildContext context, AppUiStyle appUiStyle){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          backgroundColor: appUiStyle.setBackgroundTheme(),
          title: Text(
             "Theme",
            style: TextStyle(
              color: appUiStyle.setTextTheme()
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              lightThemeButton(context, appUiStyle),
              darkThemeButton(context, appUiStyle),
              dimThemeButton(context, appUiStyle)
            ],
          ),
        );
      }
    );
  }

  Widget lightThemeButton(BuildContext context, AppUiStyle appUiStyle){
    return MaterialButton(
      minWidth: double.infinity,
      onPressed: appUiStyle.theme == "light"?
        null : (){
        appUiStyle.theme = "light";
        appUiStyle.saveChangeTheme();
        Navigator.of(context).pop();
      },
      color: Colors.white,
      disabledColor: Colors.grey.shade200,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        "Light",
        style:  TextStyle(
          fontSize: 16,
          color: Colors.black
        ),
      ),
    );
  }


  Widget darkThemeButton(BuildContext context, AppUiStyle appUiStyle){
    return MaterialButton(
      minWidth: double.infinity,
      onPressed: appUiStyle.theme == "dark" ?
        null : (){
        appUiStyle.theme = "dark";
        appUiStyle.saveChangeTheme();
        Navigator.of(context).pop();
      },
      elevation: 0.0,
      color: Colors.grey.shade800,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        "Dark",
        style: TextStyle(
          fontSize: 16,
          color: Colors.white
        ),
      ),
    );
  }

  Widget dimThemeButton(BuildContext context, AppUiStyle appUiStyle){
    return MaterialButton(
      minWidth: double.infinity,
      onPressed: appUiStyle.theme == "dim" ?
        null : (){
        appUiStyle.theme = "dim";
        appUiStyle.saveChangeTheme();
        Navigator.of(context).pop();
      },
      elevation: 0.0,
      color: const Color.fromRGBO(36, 52, 71, 1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        "Dim",
        style: TextStyle(
          fontSize: 16,
          color: Colors.white
        ),
      ),
    );
  }


    Future<void> _sendMail() async{
    final uri = Uri.parse('mailto:kberfan99@gmail.com?subject=Need help');
    await launchUrl(uri);
  
  }
}