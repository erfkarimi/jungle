import 'package:flutter/material.dart';
import '../../widget/snack_bar_widget/snack_bar_widget.dart';

void showMarkedCompSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBarWidget(
        bodyText: "Task completed",
        color: Theme.of(context).textTheme.bodyMedium!.color,
        ));
  }

void showMarkedUncompSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBarWidget(
        bodyText: "Task marked uncompleted",
        color: Theme.of(context).textTheme.bodyMedium!.color,
        ));
  }