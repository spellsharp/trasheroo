import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:trasheroo/SideBar.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Leftcard extends StatefulWidget {
  const Leftcard({Key? key}) : super(key: key);
  @override
  State<Leftcard> createState() => _LeftcardState();
}

class _LeftcardState extends State<Leftcard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        height: 161,
        width: 337,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: Color.fromRGBO(89, 90, 74, 1),
        ),
      ),
    );
  }
}

class RightCard extends StatefulWidget {
  const RightCard({Key? key}) : super(key: key);

  @override
  State<RightCard> createState() => _RightCardState();
}

class _RightCardState extends State<RightCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        height: 161,
        width: 337,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          color: Color.fromRGBO(89, 90, 74, 1),
        ),
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
    setState(() {
      imageFile = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _getFromCamera();
        print("Camera Clicked");
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
  bool _isDrawerOpen = false;

  List<String> _cardData = [
    'Card 1',
    'Card 2',
    'Card 3',
    'Card 4',
    'Card 5',
  ];

  List<Widget> _cardDisplay() {
    List<Widget> cardList = [];

    for (int i = 0; i < _cardData.length; i++) {
      if (i % 2 == 0) {
        cardList.add(Leftcard());
      } else {
        cardList.add(RightCard());
      }
    }

    return cardList;
  }

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
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 25.0),
                        child: DottedBox(),
                      ),
                      localTrash(),
                      ..._cardDisplay()
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
