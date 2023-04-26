import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackPage extends StatefulWidget {
  FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final myController = TextEditingController();

  String receiverEmail = 'boomchingshaka@google.com';

  String subject = '';

  String body = '';

  void _launchEmailApp() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: receiverEmail,
      query: 'subject=$subject&body=$body',
    );
    Uri url = params;

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(11, 110, 79, 1),
      appBar: AppBar(
        title: Text('Email Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                child: Padding(
              padding: const EdgeInsets.all(45.0),
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        subject = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Subject',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        body = value;
                      });
                    },
                    minLines: 5,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Body'),
                  )
                ],
              ),
            )),
            ElevatedButton(
              onPressed: _launchEmailApp,
              child: Text('Send Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}
