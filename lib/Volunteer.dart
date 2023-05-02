import 'package:flutter/material.dart';
import 'dart:io';
import 'HomePage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'Map.dart';
import 'RouteDistance.dart';
import 'package:location/location.dart';
import 'FullMap.dart';

class Volunteer extends StatefulWidget {
  final cardData;
  final imageFile;
  final cardDescription;
  final coordinates;
  Volunteer({
    Key? key,
    this.cardData,
    this.imageFile,
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
          // backgroundColor: const Color.fromRGBO(243, 255, 166, 1),
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
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
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
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 52, 36, 1),
                          borderRadius: BorderRadius.circular(20),
                          // image: DecorationImage(image: ),
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
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Color.fromARGB(255, 0, 97, 50),
                                  width: 4,
                                )),
                                child: Map())),
                        SizedBox(height: 20),
                        distance != null
                            ? Text(
                                "$distance Km away",
                                style:
                                    TextStyle(fontFamily: 'NTR', fontSize: 20),
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
                  onPressed: (() {
                    print("Post Button clicked");
                    _submitIssue();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  }),
                  child: Text(
                    "Volunteer",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'NTR',
                    ),
                  ),
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
