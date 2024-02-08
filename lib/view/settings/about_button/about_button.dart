import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class AboutButton extends StatelessWidget {
  const AboutButton({super.key});

  @override
  Widget build(context) {
    return MaterialButton(
      onPressed: () {
        Get.toNamed('/webView');
      },
      child: ListTile(
        leading: const Icon(
          Icons.info_outline,
        ),
        title: Text(
          AppLocalizations.of(context)!.aboutButtonTitle,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}