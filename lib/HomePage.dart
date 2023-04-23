import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:trasheroo/SideBar.dart';

class DottedBox extends StatelessWidget {
  const DottedBox({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
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
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSidebarOpen = false;
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
      backgroundColor: const Color.fromRGBO(243, 255, 166, 1),
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
              padding: EdgeInsets.zero,
              child: Image.asset(
                'assets/Logo.png',
                fit: BoxFit.contain,
                height: 70,
              ),
            )
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
        toolbarHeight: 73,
      ),
      drawer: const Sidebar(),
      body: Stack(children: [
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
                  ],
                ),
              ],
            ),
          ],
        ),
        // if (isSidebarOpen) Stack(children: [Sidebar()]),
      ]),
    );
  }
}
