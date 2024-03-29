import 'package:flutter/material.dart';
import '../../../view_model/app_ui_style/app_ui_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeButton extends StatefulWidget{
  const ThemeButton({super.key});

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton> {
  @override 
  Widget build(context){
    final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context);
    return MaterialButton(
      onPressed: (){
        setState(() {
          appUiStyle.darkTheme = !appUiStyle.darkTheme;
          appUiStyle.saveToDb(appUiStyle.darkTheme);
        });
      },
      child: ListTile(
        leading: Icon(
          appUiStyle.darkTheme ? Icons.wb_sunny_outlined
          : Icons.brightness_2_outlined),
          title: Text(
            appUiStyle.darkTheme ?
            AppLocalizations.of(context)!.lightButtonTitle
            : AppLocalizations.of(context)!.darkButtonTitle,
            style: const TextStyle(
              fontSize: 16
            ),
            ),
      ),
      );
  }
}