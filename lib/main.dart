import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/rendering.dart';
import 'package:trasheroo/Registration_Page.dart';
import 'HomePage.dart';
import 'SideBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'profile.dart';
import 'Explore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Login_Page.dart';

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

  func() {
    final user = FirebaseAuth.instance.currentUser;
    bool isuserloggedin = false;
    if (user != null) {
      isuserloggedin = true;
    }
    return (isuserloggedin);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: buildMaterialColor(const Color.fromRGBO(11, 110, 79, 1)),
      ),
      home: func() ? MyHomePage(title: "Oombu") : LoginPage(),
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
    _getVolunteerIssue();
    _getPostIssue();
    get_postIssue();
  }

  late DatabaseReference groupRef1;
  Map<String, Map<String, String>> volunteerDataMap = {};
  _getVolunteerIssue() async {
    String description = '';
    String location = '';
    String imageEncoded = '';
    groupRef1 = FirebaseDatabase.instance.ref().child('Volunteer Data');
    groupRef1.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> groupData =
            event.snapshot.value as Map<dynamic, dynamic>;
        groupData.forEach((key, value) {
          Map<String, String> volunteerData = {
            'time': value['time'],
            'e-mail': value['e-mail'],
            'issueID': value['issueID'],
          };
          if (FirebaseAuth.instance.currentUser!.email == value['e-mail']) {
            volunteerDataMap[key] = volunteerData;

            print("==================================");
            print("volunteer");

            print(volunteerDataMap);
            print("==================================");
          }
        });
      } else {
        print("Fuck");
      }
    });

    return description;
  }

  late DatabaseReference groupRef2;
  Map<String, Map<String, String>> postedDataMap = {};
  _getPostIssue() async {
    String description = '';
    String location = '';
    String imageEncoded = '';
    groupRef2 = FirebaseDatabase.instance.ref().child('postIssue');
    groupRef2.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> groupData =
            event.snapshot.value as Map<dynamic, dynamic>;
        groupData.forEach((key, value) {
          Map<String, String> postedData = {
            'body': value['body'],
            'co-ordinates': value['co-ordinates'],
            'subject': value['subject'],
          };
          if (FirebaseAuth.instance.currentUser!.email == value['user-email']) {
            postedDataMap[key] = postedData;
            print("==================================");
            print("post");

            print(postedDataMap);
            print("==================================");
          }
        });
      } else {
        print("Fuck");
      }
    });

    return description;
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
        // print("==================================");
        groupData.forEach((key, value) {
          Map<String, String> postData = {
            'id': key,
            'location': value['subject'],
            'description': value['body'],
            'coordinates': value['co-ordinates'],
            'image': value['image'],
          };
          // print("kkkkkkkkkkkkkkkkkkkkkkkkkkkk");
          // print(key);
          // print("kkkkkkkkkkkkkkkkkkkkkkkkkkkk");
          // postDataMap[key] = postData;
          // print(postDataMap);
          // print("==================================");
        });
        Home _homePage = Home();
        setState(() {
          _isLoading = false;
          _widgetOptions = <Widget>[
            Home(data: postDataMap),
            Explore(postDataMap: postDataMap),
            Profile(vdata: volunteerDataMap, pdata: postedDataMap),
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
      return SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(243, 255, 166, 1),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
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
      );
    }
  }
}
