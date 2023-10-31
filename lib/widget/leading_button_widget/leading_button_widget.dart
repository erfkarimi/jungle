import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jungle/view_model/app_ui_style/app_ui_style.dart';

class LeadingButtonWidget extends Padding{
  final AppUiStyle appUiStyle;
  LeadingButtonWidget({super.key, required this.appUiStyle}):
  super(
    padding: const EdgeInsets.symmetric(vertical: 10),
        child: MaterialButton(
          onPressed: () {
            Get.back();
          },
          minWidth: 10,
          shape:
              CircleBorder(side: BorderSide(color: appUiStyle.setTextTheme())),
          child: Icon(Icons.arrow_back, color: appUiStyle.setTextTheme()),
        ),
  );
}