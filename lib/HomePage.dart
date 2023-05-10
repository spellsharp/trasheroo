import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:trasheroo/SideBar.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:trasheroo/Volunteer.dart';
import 'postIssue.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'RouteDistance.dart';

class RightCard extends StatefulWidget {
  final cardData;
  final cardDescription;
  final coordinates;
  final id;
  final image64;
  RightCard({
    Key? key,
    this.cardData,
    this.cardDescription,
    this.coordinates,
    this.id,
    this.image64,
  }) : super(key: key);

  @override
  State<RightCard> createState() => RightCardState();
}

class RightCardState extends State<RightCard> {
  render_image(imageEncoded) {
    Uint8List bytes = base64Decode(imageEncoded);
    return Image.memory(
      bytes,
      fit: BoxFit.cover,
      height: 143.0,
      width: 337.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Volunteer(
              cardData: widget.cardData,
              cardDescription: widget.cardDescription,
              coordinates: widget.coordinates,
              image: widget.image64,
            ),
          ),
        );
        // print(widget.image64);
      }),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Color.fromRGBO(0, 24, 2, 0.498),
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              height: 161,
              width: 337,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color.fromRGBO(152, 183, 111, 0.8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(145, 167, 141, 0.494),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                      ),
                    ),
                    child: Text(
                      "#" + widget.id,
                      style: TextStyle(
                        color: Color.fromRGBO(33, 42, 24, 1),
                        fontSize: 10,
                        height: 1.5,
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Opacity(
                        opacity: 0.3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          child: render_image(widget.image64),
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 5),
                                Text(
                                  widget.cardData,
                                  style: TextStyle(
                                      color: Color.fromRGBO(33, 42, 24, 1),
                                      fontSize: 20,
                                      fontFamily: 'NTR'),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  widget.cardDescription,
                                  style: TextStyle(
                                      color: Color.fromRGBO(33, 42, 24, 1),
                                      fontSize: 16,
                                      fontFamily: 'NTR'),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  widget.coordinates,
                                  style: TextStyle(
                                      color: Color.fromRGBO(33, 42, 24, 1),
                                      fontSize: 12,
                                      fontFamily: 'NTR'),
                                ),
                              ],
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class DottedBox extends StatefulWidget {
  const DottedBox({Key? key}) : super(key: key);

  @override
  State<DottedBox> createState() => _DottedBoxState();
}

class _DottedBoxState extends State<DottedBox> {
  Location location = new Location();
  String coordinate_trash = '';
  File? imageFile;
  void _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 1080,
      maxWidth: 1080,
    );

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PostIssue(
                  imageFile: imageFile,
                  coordinates: coordinate_trash,
                )),
      );
    }
  }

  void _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1080,
    );

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PostIssue(imageFile: imageFile)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                      onTap: () => _getFromCamera(),
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text('Gallery'),
                      onTap: () => _getFromGallery(),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: DottedBorder(
        strokeWidth: 4,
        borderType: BorderType.RRect,
        padding: const EdgeInsets.all(10),
        color: const Color.fromRGBO(89, 90, 74, 1),
        dashPattern: const [9, 9],
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Container(
                height: 148,
                width: 285,
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.add,
                      size: 60,
                      color: Color.fromRGBO(89, 90, 74, 1),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Click, Upload, Clean',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'NTR',
                        color: Color.fromRGBO(89, 90, 74, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class localTrash extends StatefulWidget {
  final trashData;
  final coordinates;
  const localTrash({Key? key, this.trashData, this.coordinates})
      : super(key: key);
  @override
  State<localTrash> createState() => localTrashState();
}

class localTrashState extends State<localTrash> {
  Location location = new Location();
  LocationData? _locationData;

  List<Widget> _cardList = [];
  String _startPoint = '';
  String _endPoint = '';
  bool isLoading = false;

  Future<void> _getLocation() async {
    try {
      _locationData = await location.getLocation();
      setState(() {
        final latitude = _locationData?.latitude ?? 0.0;
        final longitude = _locationData?.longitude ?? 0.0;
        _startPoint = '$longitude,$latitude';
        _endPoint = widget.coordinates;
        isLoading = true;
      });
    } catch (e) {
      print('Could not get location: $e');
    }
  }

  String title = '';
  String details = '';
  var distance = 0.0;

  Future<void> _getDistance(String start, String end) async {
    final distance1 = await getRouteDistance(start, end);
    setState(() {
      distance = distance1;
      isLoading = false;
    });
    print(distance);
  }

  Future<void> _cardDisplayHelper() async {
    await _getLocation();
    var count = 0;
    for (var value in widget.trashData.values) {
      if (value is Map<String, String>) {
        await _getDistance(_startPoint, value['coordinates']!);
        if (count < 3) {
          if (distance < 10)
            _cardList.add(
              RightCard(
                cardData: "${value['location']!}",
                cardDescription: "${value['description']!}",
                coordinates: "${value['coordinates']!}",
                id: "${value['id']!}",
                image64: "${value['image']!}",
              ),
            );
          count++;
        }
      }
    }
  }

  @override
  void initState() {
    isLoading = true;
    super.initState();
    _cardDisplayHelper();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 38,
            width: 285,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Trash near you",
              style: TextStyle(
                fontSize: 35,
                fontFamily: 'NTR',
                color: Color.fromRGBO(0, 0, 0, 1),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
            ],
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 38,
            width: 285,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Trash near you",
              style: TextStyle(
                fontSize: 35,
                fontFamily: 'NTR',
                color: Color.fromRGBO(0, 0, 0, 1),
              ),
            ),
          ),
          ..._cardList,
        ],
      );
    }
  }
}

class Home extends StatefulWidget {
  final data;
  Home({Key? key, this.data}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = AppBar().preferredSize.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromRGBO(243, 255, 166, 1),
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              'Trasheroo',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Amatic_SC',
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () {
                  print("pressed logo");
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/Logo.png'),
                  radius: 35,
                  backgroundColor: Colors.transparent,
                ),
              ),
            )
          ],
        ),
        toolbarHeight: 73,
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: Sidebar(),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: kToolbarHeight + 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: DottedBox(),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            localTrash(
                              trashData: widget.data,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 15),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
