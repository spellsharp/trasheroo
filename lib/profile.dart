import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key}); 
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
              child: Stack(
                children: [

                  Positioned(
                    top: 264,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
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
                  ),                  
                ],
              ),
          ),
        ],
      ),
    );
  }
}