import 'package:flutter/material.dart';
import 'dart:io';
import 'HomePage.dart';

class PostIssue extends StatefulWidget {
  final File? imageFile;
  const PostIssue({Key? key, this.imageFile}) : super(key: key);

  @override
  State<PostIssue> createState() => _PostIssueState();
}

class _PostIssueState extends State<PostIssue> {
  String title = '';
  String details = '';

  void _submitIssue() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 255, 166, 1),
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            const Text(
              'Post Issue',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'NTR',
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
        toolbarHeight: 73,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 400,
                  decoration: widget.imageFile == null
                      ? null
                      : BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: FileImage(widget.imageFile!),
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ],
            ),
            SizedBox(height: 60),
            SizedBox(
              width: 350.0,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Subject',
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 350.0,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    details = value;
                  });
                },
                minLines: 5,
                maxLines: null,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Body'),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: (() {
                print("Post Button clicked");
                _submitIssue();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              }),
              child: Text(
                "Post Issue",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'NTR',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
