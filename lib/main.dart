import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/rendering.dart';
import 'HomePage.dart';
import 'SideBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'Profile.dart';
import 'Explore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore firestore = FirebaseFirestore.instance;
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DatabaseReference _groupRef;
  Map<String, Map<String, String>> postDataMap = {};
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    get_postIssue();
  }

  get_postIssue() async {
    String description = '';
    String location = '';
    String imageEncoded = '';
    _groupRef = FirebaseDatabase.instance.ref().child('postIssue');
    _groupRef.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> groupData =
            event.snapshot.value as Map<dynamic, dynamic>;
        print("==================================");
        groupData.forEach((key, value) {
          Map<String, String> postData = {
            'id': key,
            'location': value['subject'],
            'description': value['body'],
            'coordinates': value['co-ordinates'],
            'image': value['image'],
          };
          print("kkkkkkkkkkkkkkkkkkkkkkkkkkkk");
          print(key);
          print("kkkkkkkkkkkkkkkkkkkkkkkkkkkk");
          postDataMap[key] = postData;
          print(postDataMap);
          print("==================================");
        });
        Home _homePage = Home();
        setState(() {
          _isLoading = false;
          _widgetOptions = <Widget>[
            Home(data: postDataMap),
            Explore(postDataMap: postDataMap),
            Profile(),
          ];
        });
      } else {
        print("Fuck");
      }
    });

    return description;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = AppBar().preferredSize.height;
    // bool isDrawerOpen = _homePage.isDrawerOpen();
    if (_isLoading) {
      return Container(
        color: Colors.white,
        child: Center(
          child: Image.asset(
            'assets/Logo.png',
            width: 500,
            height: 500,
          ),
        ),
      );
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(milliseconds: 1500));
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => super.widget));
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Color.fromRGBO(243, 255, 166, 1),
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
              ),
              height: 87,
              child: ClipRRect(
                child: BottomNavigationBar(
                  elevation: 30.0,
                  backgroundColor: Color.fromRGBO(11, 110, 79, 0.9),
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Container(
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
                  unselectedLabelStyle: TextStyle(
                      color: Color.fromARGB(255, 107, 107, 107),
                      fontWeight: FontWeight.w500),
                  selectedLabelStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  selectedItemColor: Color.fromARGB(255, 255, 255, 255),
                  onTap: _onItemTapped,
                ),
              ),
            ),
            body: _widgetOptions[_selectedIndex],
          ),
        ),
      );
    }
  }
}
