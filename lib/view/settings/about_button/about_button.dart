import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutButton extends StatelessWidget {
  const AboutButton({super.key});

  @override
  Widget build(context) {
    return MaterialButton(
      onPressed: () {
        Get.toNamed('/webView');
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
