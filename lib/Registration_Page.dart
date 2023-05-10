import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:trasheroo/main.dart';
import 'HomePage.dart';
import 'Login_Page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController _usernameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff0B6E4F),
        body: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Container(
                  height: 275,
                  child: Container(
                    child: Image.asset(
                      "assets/Logo.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, -4),
                      ),
                    ],
                    color: Color(0xffF3FFA6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 45, vertical: 0),
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            "Create an Account",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 34,
                              fontFamily: 'NTR',
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already a Member?",
                                style: TextStyle(
                                  fontFamily: 'NTR',
                                  fontSize: 16,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                },
                                child: Text(
                                  " Sign in.",
                                  style: TextStyle(
                                    fontFamily: 'NTR',
                                    fontSize: 16,
                                    color: Color(0xff29338E),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.zero,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                                return "Enter Correct Username";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 8),
                              hintText: 'Username',
                              hintStyle:
                                  TextStyle(fontSize: 15, fontFamily: 'NTR'),
                              prefixIcon: Icon(Icons.person),
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.zero,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            controller: _emailTextController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 8),
                              hintStyle:
                                  TextStyle(fontSize: 15, fontFamily: 'NTR'),
                              border: InputBorder.none,
                              hintText: 'Email address',
                              prefixIcon: Icon(Icons.email),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.zero,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            controller: _passwordTextController,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 8),
                              hintStyle:
                                  TextStyle(fontSize: 15, fontFamily: 'NTR'),
                              border: InputBorder.none,
                              hintText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: _emailTextController.text,
                                    password: _passwordTextController.text)
                                .then((value) {
                              print("Created New Account");
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage(
                                            title: 'Trasheroo',
                                          ))); //HomePage instead of LoginPage
                            }).onError((error, stackTrace) {
                              Navigator.pop(context);
                              final _registrationerrormessage = SnackBar(
                                content: Center(
                                  child: Text(
                                    "User Can't be Registered !",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(240, 249, 250, 200)),
                                  ),
                                ),
                                backgroundColor:
                                    Color.fromARGB(255, 255, 21, 21),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(_registrationerrormessage);
                              print("Error ${error.toString()}");
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 35,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xff0B6E4F),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontFamily: 'NTR',
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xffF3FFA6),
                      border: Border(
                          top: BorderSide(
                        color: Colors.grey,
                      ))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Developed by",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'NTR',
                        ),
                      ),
                      Text(
                        " ByteForge",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Numans',
                        ),
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
