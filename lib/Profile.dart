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
            icon: const Icon(Icons.edit),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 80, left: 135),
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
                          radius: 77,
                          backgroundColor: Colors.black26,
                          child: CircleAvatar(
                            radius: 75,
                            backgroundColor: Colors.white70,
                            child: ClipOval(
                              child: Image.file(
                                image!,
                                width: 116,
                                height: 116,
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
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      backgroundColor: const Color.fromRGBO(
                                          243, 255, 166, 1),
                                      title: Text('Choose Image Source'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            GestureDetector(
                                              child: Text('Camera'),
                                              onTap: () => pickImageC(),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.all(8.0)),
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
                            // GestureDetector(
                            //   onTap: () => pickImage(),
                            //   child: const CircleAvatar(
                            //     radius: 18,
                            //     backgroundColor: Color(0xB30CAD7B),
                            //     child: Icon(
                            //       Icons.camera_alt_sharp,
                            //       color: Colors.white,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 260),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                      ),
                      color: Color.fromARGB(255, 137, 190, 165)
                      // gradient: LinearGradient(
                      //   colors: [
                      //     Color(0xffF3FFA6),
                      //     Color(0xffC4D26D),
                      //     Color(0xff98D26D),
                      //     Color(0xff77C23E),
                      //   ],
                      //   begin: Alignment.bottomCenter,
                      //   end: Alignment.topCenter,
                      // ),
                      ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 280, left: 45),
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
                Container(
                  margin: const EdgeInsets.only(top: 315, left: 45),
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
                Container(
                  margin: const EdgeInsets.only(top: 380, left: 45),
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
                Container(
                  margin: const EdgeInsets.only(top: 420, left: 45),
                  child: SizedBox(width: double.infinity, child: buildabout()),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 520, left: 45),
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
                Container(
                  margin: const EdgeInsets.only(top: 555, left: 45),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
