import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        AppSettings.openAppSettings(type: AppSettingsType.notification);
      },
      child: ListTile(
        leading: const Icon(
          Icons.notifications_outlined,
        ),
        title: Text(
          AppLocalizations.of(context)!.notificationButtonTitle,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}