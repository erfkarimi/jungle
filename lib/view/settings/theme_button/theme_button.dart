import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jungle/view_model/app_ui_style/app_ui_style.dart';
import 'package:jungle/widget/material_button_widget/material_button_widget.dart';

class ThemeButton extends StatelessWidget{
  final AppUiStyle appUiStyle;
  const ThemeButton({super.key, required this.appUiStyle});

  @override 
  Widget build(context){
    return MaterialButtonWidget(
      function: (){
        showThemeDialog(context);
      },
      buttonIcon: Icons.brightness_2_outlined,
      buttonTitle: "Theme",
      appUiStyle: appUiStyle,
      buttonTrailing: Text(
        appUiStyle.font,
        style: TextStyle(
          fontSize: 14,
          color: appUiStyle.setTextTheme()
        ),
      ),
    );
  }

  void showThemeDialog(BuildContext context){
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
              lightThemeButton(),
              darkThemeButton(),
              dimThemeButton()
            ],
          ),
        );
      }
    );
  }


  Widget lightThemeButton(){
    return MaterialButton(
      minWidth: double.infinity,
      onPressed: appUiStyle.theme == "Light"?
        null : (){
        appUiStyle.theme = "Light";
        appUiStyle.saveChangeTheme();
        Get.back();
      },
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: const Icon(Icons.brightness_1,
        color: Colors.white,),
        title: Text(
        "Light",
        style:  TextStyle(
          fontSize: 16,
          color: appUiStyle.setTextTheme()
        ),
      ),
      trailing: appUiStyle.theme == "Light" ?
        const Icon(Icons.check, color: Colors.blue,) : null,
      )
    );
  }


  Widget darkThemeButton(){
    return MaterialButton(
      minWidth: double.infinity,
      onPressed: appUiStyle.theme == "Dark" ?
        null : (){
        appUiStyle.theme = "Dark";
        appUiStyle.saveChangeTheme();
        Get.back();
      },
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(Icons.brightness_1,
        color: Colors.grey.shade800),
        title: Text(
        "Dark",
        style:  TextStyle(
          fontSize: 16,
          color: appUiStyle.setTextTheme()
        ),
      ),
      trailing: appUiStyle.theme == "Dark" ?
        const Icon(Icons.check, color: Colors.blue,) : null,
      )
    );
  }

  Widget dimThemeButton(){
    return MaterialButton(
      minWidth: double.infinity,
      onPressed: appUiStyle.theme == "Dim" ?
        null : (){
        appUiStyle.theme = "Dim";
        appUiStyle.saveChangeTheme();
        Get.back();
      },
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: const Icon(Icons.brightness_1,
        color: Color.fromRGBO(36, 52, 71, 1.0)),
        title: Text(
        "Dim",
        style:  TextStyle(
          fontSize: 16,
          color: appUiStyle.setTextTheme()
        ),
      ),
      trailing: appUiStyle.theme == "Dim" ?
        const Icon(Icons.check, color: Colors.blue,) : null,
      )
    );
  }
}