import 'package:flutter/material.dart';
import 'package:trasheroo/main.dart';
import 'dart:io';
import 'HomePage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'Map.dart';
import 'RouteDistance.dart';
import 'package:location/location.dart';
import 'FullMap.dart';
import 'main.dart';

import 'dart:typed_data';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'package:firebase_database/firebase_database.dart';

class Volunteer extends StatefulWidget {
  final cardData;
  final image;
  final cardDescription;
  final coordinates;
  Volunteer({
    Key? key,
    this.cardData,
    this.image,
    this.cardDescription,
    this.coordinates,
  }) : super(key: key);

  @override
  State<Volunteer> createState() => VolunteerState();
}

class VolunteerState extends State<Volunteer> {
  Location location = new Location();

  bool _serviceEnabled = false;
  LocationData? _locationData;
  double latitude = 0;
  double longitude = 0;
  String startPoint = '';
  String endPoint = '';
  String pub_day = '';

  render_image() {
    Uint8List bytes = base64Decode(widget.image);
    return Image.memory(
      bytes,
      fit: BoxFit.fill,
    );
  }

  void _getLocation() async {
    final _locationData = await location.getLocation();
    setState(() {
      final latitude = _locationData.latitude;
      final longitude = _locationData.longitude;
      startPoint = '$longitude,$latitude';
      endPoint = widget.coordinates;
    });
    _getDistance();
  }

  String title = '';
  String details = '';

  var distance;

  void _getDistance() async {
    final distance = await getRouteDistance(startPoint, endPoint);
    setState(() {
      this.distance = distance;
    });
  }

  void _submitIssue() {}

  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  //Volunteer backend

  final database = FirebaseDatabase.instance.ref();

  final FirebaseAuth auth = FirebaseAuth.instance;

  void volunteerdatabase(String time, String issueuid) {
    final User user = auth.currentUser!;
    final String email = user.email.toString();
    // database.child("email/$email").push().child("time/$time").push().set({
    //   'issueuid': issueuid,
    // });
    database.child("Volunteer Data").push().set({
      'e-mail': email,
      'time': time,
      'issueID': issueuid,
    });
    print("volunteer backend done");
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(milliseconds: 1500));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => super.widget));
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(243, 255, 166, 1),
          appBar: AppBar(
            titleSpacing: 0,
            title: Row(
              children: [
                const Text(
                  'Volunteer',
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
                        child: ClipRRect(
                          child: render_image(),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        decoration: BoxDecoration(
                          // ignore: prefer_const_constructors
                          color: Color.fromRGBO(0, 52, 36, 1),
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        distance != null
                            ? Text(
                                "$distance Km away",
                                style: TextStyle(
                                  fontFamily: 'NTR',
                                  fontSize: 20,
                                ),
                              )
                            : FutureBuilder(
                                future: Future(() async {
                                  while (distance == null) {
                                    await Future.delayed(
                                        Duration(milliseconds: 100));
                                  }
                                  return true;
                                }),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData && distance != null) {
                                    return Row(
                                      children: [
                                        Text(distance.toString()),
                                        Text(" km away"),
                                      ],
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                        GestureDetector(
                            onTap: () {
                              print("map clicked");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapScreenWidget(
                                          markerPoint: widget.coordinates,
                                        )),
                              );
                            },
                            child: Container(
                                child: Text("Where is it?",
                                    style: TextStyle(
                                        color: Color.fromRGBO(0, 52, 36, 1),
                                        fontSize: 17,
                                        decoration:
                                            TextDecoration.underline)))),
                        // SizedBox(height: 20),
                        Text(
                          widget.cardData,
                          style: TextStyle(fontFamily: 'NTR', fontSize: 20),
                        ),
                        Text(widget.cardDescription,
                            style: TextStyle(fontFamily: 'NTR', fontSize: 18)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  "When do you wish to start?",
                  style: TextStyle(fontFamily: 'NTR', fontSize: 25),
                ),
                TableCalendar(
                  rowHeight: 35,
                  focusedDay: today,
                  firstDay: DateTime.now(),
                  lastDay: DateTime.utc(2025, 1, 1),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  onDaySelected: _onDaySelected,
                  headerStyle: HeaderStyle(
                    leftChevronVisible: false,
                    rightChevronVisible: false,
                    titleCentered: true,
                    headerPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    formatButtonVisible: false,
                  ),
                  availableGestures: AvailableGestures.all,
                  selectedDayPredicate: (day) => isSameDay(day, today),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  child: Text(
                    "Volunteer",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'NTR',
                    ),
                  ),
                  onPressed: (() {
                    print("volunteer pressed");
                    pub_day = today.toString().split(" ")[0];

                    volunteerdatabase(pub_day, "issueID");
                    print("Post Button clicked");
                    _submitIssue();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage(title: "Oombu")),
                    );
                  }),
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
