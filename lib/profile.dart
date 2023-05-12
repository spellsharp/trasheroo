import 'package:flutter/material.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';

class Profile extends StatefulWidget {
  final vdata;
  final pdata;
  Profile({Key? key, this.vdata, this.pdata}) : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String username = 'ByteForge';
  String email = 'byte@forge.com';
  String profilePic = '';
  String about = 'Save Earth';
  bool isEditing = false;
  TextEditingController nameController = TextEditingController();
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  final int nameLimit = 70;
  void toggleEdit() {
    setState(() {
      isEditing = !isEditing;
      if (!isEditing) {
        about = nameController.text;
      }
    });
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Widget buildabout() {
    if (isEditing) {
      return Row(
        children: [
          Expanded(
            child: TextField(
              controller: nameController,
              maxLength: nameLimit,
              decoration: const InputDecoration(
                hintText: 'About',
              ),
            ),
          ),
          IconButton(
            onPressed: toggleEdit,
            icon: const Icon(Icons.done),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: Text(
              about,
              style: const TextStyle(
                fontFamily: 'NTR',
                color: Color.fromRGBO(0, 0, 0, 1),
                fontSize: 25,
                height: 1,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          IconButton(
            onPressed: toggleEdit,
            icon: const Icon(
              Icons.edit,
              color: Color.fromARGB(255, 0, 61, 2),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 255, 166, 1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 90.0,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 128, 90, 1),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5))),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            title: Text('Choose Image Source'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  GestureDetector(
                                    child: Text('Camera'),
                                    onTap: () => pickImageC(),
                                  ),
                                  Padding(padding: EdgeInsets.all(8.0)),
                                  GestureDetector(
                                    child: Text('Gallery'),
                                    onTap: () => pickImage(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Stack(
                      children: [
                        if (image == null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 55,
                              backgroundColor: Colors.black26,
                              child: const CircleAvatar(
                                radius: 45,
                                backgroundColor: Colors.white70,
                                child: Icon(Icons.person, size: 60),
                              ),
                            ),
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 55,
                              backgroundColor: Colors.black38,
                              child: CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.white70,
                                backgroundImage: FileImage(image!),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ByteForge",
                        style: TextStyle(
                          fontSize: 22,
                          height: 1.4,
                          fontFamily: 'NTR',
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                      Text(
                        "byte@forge.com",
                        style: TextStyle(
                          height: 1.4,
                          fontSize: 17,
                          fontFamily: 'NTR',
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                const Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 8.0, right: 10.0),
                  child: Text(
                    "About",
                    style: TextStyle(
                      height: 1.4,
                      fontSize: 20,
                      fontFamily: 'NTR',
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 20.0, bottom: 10.0),
                  child: Container(color: Colors.black38, height: 1.5),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Container(
                    child:
                        SizedBox(width: double.infinity, child: buildabout()),
                  ),
                ),
                SizedBox(height: 40),
                const Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("My Posts",
                      style: TextStyle(
                        height: 1.4,
                        fontSize: 20,
                        fontFamily: 'NTR',
                        color: Color.fromRGBO(0, 0, 0, 1),
                      )),
                ),
                // ..._buildPosts(),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 24.0),
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 198, 255, 158),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(widget.pdata.toString()),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("Volunteered Posts",
                      style: TextStyle(
                        height: 1.4,
                        fontSize: 20,
                        fontFamily: 'NTR',
                        color: Color.fromRGBO(0, 0, 0, 1),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 24.0),
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 198, 255, 158),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(widget.vdata.toString()),
                      ),
                    ),
                  ),
                ),
                // ..._buildVolunteers(),
                SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
