import 'package:flutter/material.dart';
import 'HomePage.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Text('Explore Page'),
    Text('Profile Page'),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    @override
    Widget build(BuildContext context) {
      final double appBarHeight = AppBar().preferredSize.height;
      return Scaffold(
        backgroundColor: const Color.fromRGBO(243, 255, 166, 1),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          ),
          height: 87,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
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
                              // color: Color.fromARGB(255, 255, 255, 255)
                              )),
                      child: Icon(Icons.home, size: 42)),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                      // margin: const EdgeInsets.all(10.0),
                      // padding: const EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              // color: Color.fromARGB(255, 255, 255, 255)
                              )),
                      child: Icon(Icons.explore, size: 42)),
                  label: 'Explore',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                      // margin: const EdgeInsets.all(10.0),
                      // padding: const EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              // color: Color.fromARGB(255, 255, 255, 255)
                              )),
                      child: Icon(Icons.person, size: 42)),
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
