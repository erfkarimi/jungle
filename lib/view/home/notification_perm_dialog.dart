part of 'home_page.dart';

void notificationPermissionFunc(BuildContext context) {
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                    AppLocalizations.of(context)!.notificationPerDialogTitle),
                content: Text(
                    AppLocalizations.of(context)!.notificationPerDialogContent),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        AppLocalizations.of(context)!
                            .notificationPerDialogFirstButton,
                        style: const TextStyle(color: Colors.grey, fontSize: 18),
                      )),
                  TextButton(
                      onPressed: () {
                        AwesomeNotifications()
                            .requestPermissionToSendNotifications()
                            .then((_) {
                          Navigator.pop(context);
                        });
                      },
                      child: Text(
                        AppLocalizations.of(context)!
                            .notificationPerDialogSecondButton,
                        style: TextStyle(
                            fontSize: 18,
                            color: Palette.ultramarineBlue,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ));
    }
  });
}
