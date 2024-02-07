import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widget/snack_bar_widget/snack_bar_widget.dart';

void showMarkedCompSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBarWidget(
        bodyText: AppLocalizations.of(context)!.firstSnackBarTitle,
        color: Theme.of(context).textTheme.bodyMedium!.color,
        ));
  }

void showMarkedUncompSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBarWidget(
        bodyText: AppLocalizations.of(context)!.secondSnackBarTitle,
        color: Theme.of(context).textTheme.bodyMedium!.color,
        ));
  }