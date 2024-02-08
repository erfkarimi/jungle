import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FeedbackButton extends StatelessWidget {
  const FeedbackButton({super.key});

  @override
  Widget build(context) {
    return MaterialButton(
      onPressed: () => _sendMail(),
      child: ListTile(
        leading: const Icon(
          Icons.question_mark,
        ),
        title: Text(
          AppLocalizations.of(context)!.feedbackButtonTitle,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

Future<void> _sendMail() async {
  final uri = Uri.parse('mailto:kberfan99@gmail.com?subject=Need help');
  await launchUrl(uri);
}