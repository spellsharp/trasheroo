import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  TextEditingController nameController = TextEditingController();
  String about = 'Save Earth';
  bool isEditing = false;
  final int nameLimit = 70;
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

  @override
  void initState() {
    super.initState();
    nameController.text = about;
  }

  void toggleEdit() {
    setState(() {
      isEditing = !isEditing;
      if (!isEditing) {
        about = nameController.text;
      }
    });
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
                hintText: 'About ',
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
      body: Column(
        children: [
          Container(height: 50),
          Container(
            child: Stack(
              children: [
                if (image == null)
                  CircleAvatar(
                    radius: 77,
                    backgroundColor: Colors.black26,
                    child: const CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.white70,
                      child: Icon(Icons.person, size: 75),
                    ),
                  )
                else
                  CircleAvatar(
                    radius: 78,
                    backgroundColor: Colors.black38,
                    child: CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.white70,
                      child: ClipOval(
                        child: Image.file(
                          image!,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Column(
                    children: [
                      const SizedBox(height: 32.0),
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
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundColor: Color(0xB30CAD7B),
                          child: Icon(
                            Icons.camera_alt_sharp,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(height: 30),
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color.fromRGBO(12, 48, 15, 0.498),
                  ),
                  // borderRadius: BorderRadius.only(
                  //     topLeft: Radius.circular(50.0),
                  //     topRight: Radius.circular(50.0),
                  //   ),
                  borderRadius: BorderRadius.circular(50)),
              color: Color.fromRGBO(152, 183, 111, 1),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                  // color: Color.fromARGB(70, 86, 119, 42),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, top: 10),
                        child: Container(
                          child: const Text(
                            'Username',
                            style: TextStyle(
                              fontFamily: 'NTR',
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, bottom: 20),
                        child: Container(
                          child: const Text(
                            'ByteForge', // backend
                            style: TextStyle(
                              fontFamily: 'NTR',
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 25,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Container(
                          child: const Text(
                            'About',
                            style: TextStyle(
                              fontFamily: 'NTR',
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, bottom: 20),
                        child: Container(
                          child: SizedBox(
                              width: double.infinity, child: buildabout()),
                        ),
                      ),
                      // SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Container(
                          child: const Text(
                            'Email Address',
                            style: TextStyle(
                              fontFamily: 'NTR',
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Container(
                          child: const Text(
                            'byte@forge.com',
                            style: TextStyle(
                              fontFamily: 'NTR',
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 25,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(height: 58)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

