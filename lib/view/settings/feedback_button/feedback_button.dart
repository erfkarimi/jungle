import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackButton extends StatelessWidget{
  const FeedbackButton({super.key});

  @override
  Widget build(context){
    return MaterialButton(
      onPressed: ()=> _sendMail(),
      child: const ListTile(
        leading: Icon(
          Icons.question_mark,
          ),
          title: Text(
            "Feedback",
            style: TextStyle(
              fontSize: 16
            ),
            ),
      ),
      );
  }
}

  Future<void> _sendMail() async{
    final uri = Uri.parse('mailto:kberfan99@gmail.com?subject=Need help');
    await launchUrl(uri);
  
  }