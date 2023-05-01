import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:trasheroo/SideBar.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:trasheroo/Volunteer.dart';
import 'postIssue.dart';

class RightCard extends StatefulWidget {
  final cardData;
  final cardDescription;
  final coordinates;
  const RightCard(
      {Key? key, this.cardData, this.cardDescription, this.coordinates})
      : super(key: key);

  @override
  State<RightCard> createState() => _RightCardState();
}

class _RightCardState extends State<RightCard> {
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
            ),
          ),
        );
      }),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
            height: 161,
            width: 337,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color.fromRGBO(89, 90, 74, 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.cardData,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'NTR')),
                          SizedBox(width: 10),
                          Text(widget.cardDescription,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'NTR')),
                          SizedBox(width: 10),
                          Text(widget.coordinates,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontFamily: 'NTR')),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
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

      // Navigate to a new page after selecting a photo
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PostIssue(imageFile: imageFile)),
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

      // Navigate to a new page after selecting a photo
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
        // _getFromCamera();
        // print("Camera Clicked");

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: const Color.fromRGBO(243, 255, 166, 1),
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
        // radius: const Radius.circular(12),
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
                      'Click, Upload, Clean Up',
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
  const localTrash({Key? key}) : super(key: key);
  @override
  State<localTrash> createState() => localTrashState();
}

class localTrashState extends State<localTrash> {
  late String heading;
  late String cardData;
  Map<String, Map<String, String>> _cardData = {
    'Card 1': {
      'Location': 'Kannur',
      'Description': 'Some description for Card 1',
      'Coordinate': '75.3704,11.8745',
    },
    'Card 2': {
      'Location': 'Amritapuri',
      'Description': 'Some description for Card 2',
      'Coordinate': '76.4896,9.0949',
    },
    'Card 3': {
      'Location': 'Chennai',
      'Description': 'Some description for Card 3',
      'Coordinate': '80.2707,13.0827',
    },
    'Card 4': {
      'Location': 'Mahe',
      'Description': 'Some description for Card 4',
      'Coordinate': '75.5343,11.7002',
    },
    'Card 5': {
      'Location': 'Ernakulam',
      'Description': 'Some description for Card 5',
      'Coordinate': '76.2999,9.9816',
    },
  };

  List<Widget> _cardDisplay() {
    List<Widget> cardList = [];

    _cardData.forEach((key, value) {
      if (value is Map<String, String>) {
        cardList.add(RightCard(
          cardData: "${value['Location']}",
          cardDescription: "${value['Description']}",
          coordinates: "${value['Coordinate']}",
        ));
      } else {
        cardList.add(RightCard(cardData: value));
      }
    });

    return cardList;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        ..._cardDisplay()
      ],
    );
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Explore Page'),
    Text('Profile Page'),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = AppBar().preferredSize.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color.fromRGBO(243, 255, 166, 1),
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          // crossAxisAlignment: CrossAxisAlignment.end,
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
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/Logo.png'),
                radius: 35,
                backgroundColor: Colors.transparent,
              ),
            )
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
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
        child: Stack(children: [
          Column(
            children: [
              Container(
                height: kToolbarHeight + 25,
              ),
              Row(
                children: [
                  SizedBox(width: 15),
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
                          localTrash(),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
