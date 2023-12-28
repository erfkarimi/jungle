import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: (){
        Share.share(
          "To use it check this link : https://github.com/erfkarimi/jungle/releases",
          subject: "Jungle");
      },
      child: const ListTile(
        leading: Icon(
          Icons.person_add_outlined,
          ),
          title: Text(
            "Invite friends",
            style: TextStyle(
              fontSize: 16
            ),
            ),
      ),
      );
  }
}