import 'package:flutter/material.dart';

class SnackBarWidget extends SnackBar{
  final String bodyText;
  final Color? color;

  SnackBarWidget({
    super.key,
    required this.bodyText,
    this.color})
  : super(
    behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            const Icon(Icons.check),
            const SizedBox(width: 10),
            Text(
              bodyText,
              style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold),
            ),
          ],
        )
  );
}