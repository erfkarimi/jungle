import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class DeleteDialogWidget extends AlertDialog {
  final int index;
  final VoidCallback firstButtonFunction;
  const DeleteDialogWidget(
      {super.key, required this.index, required this.firstButtonFunction});

  @override
  Widget build(context) {
    return AlertDialog(
        title: Text(AppLocalizations.of(context)!.dialogTitle,
            style: const TextStyle()),
        content: Text(AppLocalizations.of(context)!.dialogContent),
        actions: [
          TextButton(
            onPressed: firstButtonFunction,
            child: Text(
              AppLocalizations.of(context)!.firstDialogButtonTitle,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              AppLocalizations.of(context)!.secondDialogButtonTitle,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          )
        ]);
  }
}
