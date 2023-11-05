import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jungle/view_model/app_ui_style/app_ui_style.dart';
import 'package:jungle/widget/material_button_widget/material_button_widget.dart';

class FontButton extends StatelessWidget{
  final AppUiStyle appUiStyle;
  const FontButton({super.key, required this.appUiStyle});

  @override 
  Widget build(context){
    return MaterialButtonWidget(
      function: (){
        showFontDialog(context, appUiStyle);
      },
      buttonIcon: Icons.translate,
      buttonTitle: "Font",
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

  void showFontDialog(BuildContext context, AppUiStyle appUiStyle){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          backgroundColor: appUiStyle.setBackgroundTheme(),
          title: Text(
            "Font",
            style: TextStyle(
              color: appUiStyle.setTextTheme(),
              fontFamily: appUiStyle.font
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              italicFontButton(context, appUiStyle),
              regularFontButton(context, appUiStyle),
            ]
          ),
        );
      }
    );
  }

  Widget italicFontButton(BuildContext context, AppUiStyle appUiStyle){
    return MaterialButton(
      minWidth: double.infinity,
        onPressed: appUiStyle.font == "Italic" ? null :(){
          appUiStyle.setAppFont("Italic");
          appUiStyle.saveChangeTheme();
          Get.back();
        },
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
      ),
        child: ListTile(
          leading: Text(
            "Aa",
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Italic",
              fontWeight: FontWeight.bold,
              color: appUiStyle.setTextTheme()
            ),
          ),
          title: Text(
            "Italic",
            style: TextStyle(
              color: appUiStyle.setTextTheme(),
              fontFamily: appUiStyle.font
            ),
          ),
          trailing: appUiStyle.font == "Italic"?
            const Icon(
            Icons.check,
            color: Colors.blue,
          ) : null,
        )
    );
  }

  Widget regularFontButton(BuildContext context, AppUiStyle appUiStyle){
    return TextButton(
        onPressed: appUiStyle.font == "Regular" ? null :(){
          appUiStyle.setAppFont("Regular");
          appUiStyle.saveChangeTheme();
          Get.back();
        },
        child: ListTile(
          leading: Text(
            "Aa",
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Regular",
              fontWeight: FontWeight.bold,
              color: appUiStyle.setTextTheme()
            ),
          ),
          title: Text(
            "Regular",
            style: TextStyle(
              fontFamily: appUiStyle.font,
              color: appUiStyle.setTextTheme()
            ),
          ),
          trailing: appUiStyle.font == "Regular"?
            const Icon(
            Icons.check,
            color: Colors.blue,
          ) : null,
        )
    );
  }
}
