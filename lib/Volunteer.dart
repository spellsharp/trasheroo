import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:trasheroo/main.dart';
import 'dart:io';
import 'HomePage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'Map.dart';
import 'RouteDistance.dart';
import 'package:location/location.dart';
import 'FullMap.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'main.dart';

class Volunteer extends StatefulWidget {
  final cardData;
  final imageFile;
  final cardDescription;
  final coordinates;
  final image;
  final id;
  Volunteer({
    Key? key,
    this.cardData,
    this.imageFile,
    this.cardDescription,
    this.coordinates,
    this.image,
    this.id,
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
    print("==============");
    print(startPoint);
    print("==============");
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

  void volunteerdatabase(String? time, String? issueuid) {
    final User user = auth.currentUser!;
    final String email = user.email.toString();

    if (time != null && issueuid != null) {
      database.child("Volunteer Data").push().set({
        'e-mail': email,
        'time': time,
        'issueID': issueuid,
      });
      print("volunteer backend done");
    } else {
      print("time or issueuid is null");
    }
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                child: Row(
                              children: [
                                Text("Where is it?",
                                    style: TextStyle(
                                        color: Color.fromRGBO(0, 52, 36, 1),
                                        fontSize: 17,
                                        decoration: TextDecoration.underline)),
                                Icon(
                                  Icons.location_pin,
                                  size: 18,
                                ),
                              ],
                            ))),
                        SizedBox(height: 20),
                        distance != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "DISTANCE",
                                    style: TextStyle(
                                        fontSize: 15, fontFamily: 'NTR'),
                                  ),
                                  Text(
                                    "$distance Km away",
                                    style: TextStyle(
                                      fontFamily: 'NTR',
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "LOCATION",
                              style: TextStyle(fontSize: 15, fontFamily: 'NTR'),
                            ),
                            Text(
                              widget.cardData,
                              style: TextStyle(fontFamily: 'NTR', fontSize: 20),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Container(height: 1, color: Colors.black38),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "DESCRIPTION",
                              style: TextStyle(fontSize: 15, fontFamily: 'NTR'),
                            ),
                            Text(widget.cardDescription,
                                style:
                                    TextStyle(fontFamily: 'NTR', fontSize: 18)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  "When do you wish to start?",
                  style: TextStyle(fontFamily: 'NTR', fontSize: 25),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TableCalendar(
                    calendarStyle: CalendarStyle(
                      todayDecoration:
                          BoxDecoration(color: Color.fromARGB(255, 45, 112, 0)),
                      selectedDecoration: BoxDecoration(
                        color: Color.fromARGB(255, 30, 196, 8),
                      ),
                      tableBorder: TableBorder.all(
                        color: Color.fromARGB(255, 4, 34, 3),
                        width: 1.0,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      canMarkersOverflow: true,
                    ),
                    rowHeight: 35,
                    focusedDay: today,
                    firstDay: DateTime.now(),
                    lastDay: DateTime.utc(2025, 1, 1),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    onDaySelected: _onDaySelected,
                    headerStyle: HeaderStyle(
                      leftChevronVisible: true,
                      rightChevronVisible: true,
                      titleCentered: true,
                      headerPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      formatButtonVisible: false,
                    ),
                    availableGestures: AvailableGestures.all,
                    selectedDayPredicate: (day) => isSameDay(day, today),
                  ),
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

                    volunteerdatabase(pub_day, widget.id);

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
