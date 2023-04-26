import 'package:flutter/material.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:trasheroo/Feedback.dart';
import 'AboutUs.dart';

class Sidebar extends StatefulWidget {
  Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  String username = 'ByteForge';
  String email = 'trasheroo@gmail.com';
  AssetImage? profilePic;

  @override
  Widget build(BuildContext context) => Drawer(
        child: Container(
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(20)
          // ),
          // width: MediaQuery.of(context).size.width * 0.8,
          // color: Color.fromRGBO(11, 110, 79, 0.9),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black87),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(12, 173, 123, 1),
                  Color.fromRGBO(14, 80, 59, 0.94),
                ]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DropShadow(
                blurRadius: 0.1,
                offset: const Offset(0.1, 0.1),
                spread: 0.5,
                // opacity: 0.5,
                child: Container(
                  height: 84.0,
                  width: 305,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromRGBO(12, 173, 123, 1),
                            Color.fromRGBO(26, 225, 154, 0),
                          ]),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/ByteForge.png'),
                            radius: 30,
                          )),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Text(
                              username,
                              style: TextStyle(
                                fontSize: 20,
                                height: 1.2,
                                fontFamily: 'NTR',
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Text(
                              email,
                              style: TextStyle(
                                height: 1.2,
                                fontSize: 15,
                                fontFamily: 'NTR',
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "About",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'NTR', fontSize: 25),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AboutUs()),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 18.0),
                child: Container(
                  height: 1,
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
                ),
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8),
                  child: Text(
                    "Contact Us",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'NTR', fontSize: 25),
                  ),
                ),
                onTap: () => print("Contact Us"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 18.0),
                child: Container(
                  height: 1,
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
                ),
              ),
              GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8),
                    child: Text(
                      "Feedback",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'NTR', fontSize: 25),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FeedbackPage()),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 18.0),
                child: Container(
                  height: 1,
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(left: 120),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'NTR', fontSize: 25),
                  ),
                ),
                onTap: () => print("Logout"),
              ),
            ],
          ),
        ),
      );
}
