import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'HomePage.dart';
import 'SideBar.dart';
import 'profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  MaterialColor buildMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: buildMaterialColor(const Color.fromRGBO(11, 110, 79, 1)),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  Home _homePage = Home();
  // bool sideBarOpen = false;
  // bool _show = true;

  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Text('Explore Page'),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // void showBottomBar() {
  //   setState(() {
  //     _show = true;
  //   });
  // }

  // void hideBottomBar() {
  //   setState(() {
  //     _show = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = AppBar().preferredSize.height;
    // bool isDrawerOpen = _homePage.isDrawerOpen();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 255, 166, 1),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        ),
        height: 87,
        child: ClipRRect(
          // borderRadius: const BorderRadius.only(
          //   topLeft: Radius.circular(25.0),
          //   topRight: Radius.circular(25.0),
          // ),
          child: BottomNavigationBar(
            elevation: 30.0,
            backgroundColor: Color.fromRGBO(11, 110, 79, 0.9),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Container(
                    // margin: const EdgeInsets.all(10.0),
                    // padding: const EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            color: Color.fromARGB(255, 255, 255, 255))),
                    child: Icon(
                      Icons.home,
                      size: 42,
                      color: Colors.white,
                    )),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Container(
                    // margin: const EdgeInsets.all(10.0),
                    // padding: const EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            color: Color.fromARGB(255, 255, 255, 255))),
                    child: Icon(
                      Icons.explore,
                      size: 42,
                      color: Colors.white,
                    )),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Container(
                    // margin: const EdgeInsets.all(10.0),
                    // padding: const EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            color: Color.fromARGB(255, 255, 255, 255))),
                    child: Icon(
                      Icons.person,
                      size: 42,
                      color: Colors.white,
                    )),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Color.fromARGB(255, 255, 255, 255),
            onTap: _onItemTapped,
          ),
        ),
      ),
      body: _widgetOptions[_selectedIndex],
    );
  }
}
