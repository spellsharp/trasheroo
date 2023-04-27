import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key}); 
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  TextEditingController nameController = TextEditingController();
  String about = '';
  bool isEditing = false;
  final int nameLimit = 70;

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
                    margin: const EdgeInsets.only(top: 80, left:110),
                    child: Stack(
                      children: const [
                        CircleAvatar(
                          radius: 58,
                          backgroundColor: Colors.white70,
                          child: Icon(Icons.person, size: 50),
                        ),
                        Positioned(
                          bottom: 0,
                          right:0,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Color(0xB30CAD7B),
                            child: Icon(
                              Icons.camera_alt_sharp,
                              color: Colors.white,),
                          ),
                        ),
                      ],
                    ),
                  ),                  
                // Container(
                //   margin: const EdgeInsets.only(top: 80, left:110),
                //   child: const CircleAvatar(
                //     radius: 72,
                //     backgroundColor: Colors.white,
                //     backgroundImage: AssetImage("assets/default.png"),
                //   ),
                // ),
                Container(
                  margin: const EdgeInsets.only(top: 260),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xffF3FFA6),
                        Color(0xffC4D26D),
                        Color(0xff98D26D),
                        Color(0xff77C23E),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 275, left: 45),
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
                  margin: const EdgeInsets.only(top: 305, left: 45),
                  child: const Text(
                    'Default Username', // backend
                    style: TextStyle(
                      fontFamily: 'NTR',
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 360, left: 35),
                  height: 2,
                  width: 295,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 365, left: 45),
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
                  margin: const EdgeInsets.only(top: 400, left: 45),
                  child: buildabout(),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 490, left: 35),
                  height: 2,
                  width: 295,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 500, left: 45),
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
                  margin: const EdgeInsets.only(top: 535, left: 45),
                  child: const Text(
                    'Default Email',
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