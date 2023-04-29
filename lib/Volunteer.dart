import 'package:flutter/material.dart';
import 'dart:io';
import 'HomePage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'Map.dart';

class Volunteer extends StatefulWidget {
  final cardData;
  final imageFile;
  final cardDescription;
  const Volunteer(
      {Key? key, this.cardData, this.imageFile, this.cardDescription})
      : super(key: key);

  @override
  State<Volunteer> createState() => VolunteerState();
}

class VolunteerState extends State<Volunteer> {
  String title = '';
  String details = '';
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  void _submitIssue() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(243, 255, 166, 1),
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
                      Map(),
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
    );
  }
}
