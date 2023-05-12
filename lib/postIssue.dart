import 'package:flutter/material.dart';
import 'package:trasheroo/main.dart';
import 'dart:io';
import 'dart:convert';
import 'HomePage.dart';
import 'Map.dart';
import 'package:firebase_database/firebase_database.dart';
import 'main.dart';
import 'package:location/location.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostIssue extends StatefulWidget {
  final File? imageFile;
  final coordinates;
  const PostIssue({Key? key, this.imageFile, this.coordinates})
      : super(key: key);

  @override
  State<PostIssue> createState() => _PostIssueState();
}

class _PostIssueState extends State<PostIssue> {
  final Location location = Location();
  LocationData? currentLocation;
  String coordinates = '';

  Future<void> getCurrentLocation() async {
    try {
      currentLocation = await location.getLocation();
      _showLocationAlertDialog(true);
      setState(() {
        coordinates =
            '${currentLocation?.longitude},${currentLocation?.latitude}';
      });
      print("====================================");
      print(coordinates);
      print("====================================");
    } catch (e) {
      _showLocationAlertDialog(false);
      print("====================================");
      print('Could not get location: $e');
      print("====================================");
    }
  }

  void _showLocationAlertDialog(bool isLocationAcquired) {
    String title, message;
    if (isLocationAcquired) {
      title = 'Location Acquired';
      message = 'Your current location has been acquired.';
    } else {
      title = 'Location Error';
      message =
          'Unable to acquire your current location. Ensure location is turned on and restart the app.';
    }

    // set up the button
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss the dialog
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  final database = FirebaseDatabase.instance.ref();
  String title = '';
  String details = '';
  String image = '';

  @override
  void initState() {
    if (widget.imageFile != null) {
      List<int> imageBytes = widget.imageFile!.readAsBytesSync();
      image = base64Encode(imageBytes);
    }
    getCurrentLocation();
    super.initState();
  }

  void insertData(
      String subject, String body, String image, String coordinates) {
    if (coordinates != "") {
      database.child("postIssue").push().set({
        'subject': subject,
        'body': body,
        'image': image,
        'co-ordinates': coordinates,
        'user-email': FirebaseAuth.instance.currentUser!.email,
      });
    } else {}
  }

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
                    hintText: 'Location(with Landmark)',
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
                      border: OutlineInputBorder(), hintText: 'Description'),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: (() {
                  print("Post Button clicked");
                  insertData(title, details, image, coordinates);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(
                              title: 'postIssuetest',
                            )),
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
