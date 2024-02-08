import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Share.share(
            "Hi, Jungle is a task manager app, to get it you can check this link out : https://github.com/erfkarimi/jungle/releases",
            subject: "Jungle");
      },
      child: ListTile(
        leading: const Icon(
          Icons.person_add_outlined,
        ),
        title: Text(
          AppLocalizations.of(context)!.shareButtonTitle,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}