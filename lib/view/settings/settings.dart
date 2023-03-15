import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../view_model/set_theme/set_theme.dart';

class Settings extends StatelessWidget{
  const Settings({super.key});
  
  @override 
  Widget build(context){
    final SetTheme setTheme = Provider.of<SetTheme>(context);
    return Scaffold(
      backgroundColor: setTheme.setBackgroundTheme(),
      appBar: buildAppBar(context, setTheme),
      body: buildBody(context, setTheme)
    );
  }

  AppBar buildAppBar(BuildContext context, SetTheme setTheme){
    return AppBar(
      backgroundColor: setTheme.setAppBarTheme(),
      elevation: 0.0,
      title: Text(
        "Settings",
        style: TextStyle(
          color: setTheme.setTextTheme(),
        ),
      ),
      leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: MaterialButton(
            onPressed: (){
              Navigator.of(context).pop(
                PageTransition(
                  type: PageTransitionType.leftToRight,
                  child: const Settings()
                )
              );
            },
            minWidth: 10,
            shape: CircleBorder(
              side: BorderSide(
                color: setTheme.setTextTheme()
              )
            ),
            child: Icon(
            Icons.arrow_back,
            color: setTheme.setTextTheme()
            ),
          ),
        ),
    );
  }

  Widget buildBody(BuildContext context, SetTheme setTheme){
    return Column(
      children: [
        themeButton(context, setTheme),
        feedbackButton(context, setTheme)
      ],
    );
  }


  Widget themeButton(BuildContext context, SetTheme setTheme){
    return MaterialButton(
      onPressed: (){
        showThemeDialog(context, setTheme);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: ListTile(
        leading: Icon(
          Icons.brightness_2_outlined,
          color: setTheme.setTextTheme(),
          ),
          title: Text(
             "Theme",
            style: TextStyle(
              color: setTheme.setTextTheme(),
            ),
            ),
      )
    );
  }


  Widget feedbackButton(BuildContext context, SetTheme setTheme){
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
          color: setTheme.setTextTheme(),
          ),
          title: Text(
            "Feedback",
            style: TextStyle(
              color: setTheme.setTextTheme()
            ),
            ),
      )
    );
  }

  void showThemeDialog(BuildContext context, SetTheme setTheme){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          backgroundColor: setTheme.setBackgroundTheme(),
          title: Text(
             "Theme",
            style: TextStyle(
              color: setTheme.setTextTheme()
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              lightThemeButton(context, setTheme),
              darkThemeButton(context, setTheme)
            ],
          ),
        );
      }
    );
  }

  Widget lightThemeButton(BuildContext context, SetTheme setTheme){
    return MaterialButton(
      minWidth: double.infinity,
      onPressed: (){
        setTheme.theme = "light";
        setTheme.saveChangeTheme();
        Navigator.of(context).pop();
      },
      color: setTheme.setAppBarTheme(),
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide()
      ),
      child: Text(
        "Light",
        style:  TextStyle(
          fontSize: 17,
          color: setTheme.setTextTheme()
        ),
      ),
    );
  }


  Widget darkThemeButton(BuildContext context, SetTheme setTheme){
    return MaterialButton(
      minWidth: double.infinity,
      onPressed: (){
        setTheme.theme = "dark";
        setTheme.saveChangeTheme();
        Navigator.of(context).pop();
      },
      elevation: 0.0,
      color: setTheme.setAppBarTheme(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide()
      ),
      child: Text(
        "Dark",
        style: TextStyle(
          fontSize: 17,
          color: setTheme.setTextTheme()
        ),
      ),
    );
  }


    Future<void> _sendMail() async{
    final uri = Uri.parse('mailto:kberfan99@gmail.com?subject=Need help');
    await launchUrl(uri);
  
  }
}