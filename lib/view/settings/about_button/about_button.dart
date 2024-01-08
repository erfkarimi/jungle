import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jungle/view/settings/about_button/web_view_page/web_view_page.dart';

class AboutButton extends StatelessWidget {
  const AboutButton({super.key});

  @override
  Widget build(context) {
    return MaterialButton(
      onPressed: () {
        Get.to(() => const WebViewPage());
      },
      child: const ListTile(
        leading: Icon(
          Icons.info_outline,
        ),
        title: Text(
          "About",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
