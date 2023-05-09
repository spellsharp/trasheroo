import 'package:flutter/material.dart';
import 'dart:io';
import 'HomePage.dart';
import 'Map.dart';

class PostIssue extends StatefulWidget {
  final File? imageFile;
  final coordinates;
  const PostIssue({Key? key, this.imageFile, this.coordinates})
      : super(key: key);

  @override
  State<PostIssue> createState() => _PostIssueState();
}

class _PostIssueState extends State<PostIssue> {
  String title = '';
  String details = '';
  void _submitIssue() {}

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(milliseconds: 1500));
      },
      child: Scaffold(
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
                    width: 350,
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
              SizedBox(height: 30),
              Container(
                child: Map(),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 0, 92, 49),
                    width: 4,
                  ),
                ),
              ),
              SizedBox(height: 30),
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
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
