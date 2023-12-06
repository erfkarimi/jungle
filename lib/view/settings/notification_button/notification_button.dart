import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: (){
        AppSettings.openAppSettings(type: AppSettingsType.notification);
      },
      child: const ListTile(
        leading: Icon(
          Icons.notifications_outlined,
          ),
          title: Text(
            "Notification",
            style: TextStyle(
              fontSize: 16
            ),
            ),
      ),
      );
  }
}