part of 'home_page.dart';

void notificationPermissionFunc(BuildContext context) {
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Allow notifications"),
                content:
                    const Text("Our app would like to send you notifications"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Don\'t allow',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
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
                        'Allow',
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
