import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';

import 'HomePage.dart';
import 'Registration_Page.dart';
import 'Reset_Password.dart';
import 'main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                            "Sign In",
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
                                "Not a Member?",
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
                                          builder: (context) =>
                                              RegistrationPage()));
                                },
                                child: Text(
                                  " Sign up.",
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
                            controller: _emailTextController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 8),
                              hintText: 'Email address',
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
                        SizedBox(height: 17),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResetPasswordPage()));
                          },
                          child: Container(
                            child: Row(
                              children: [
                                SizedBox(width: 194),
                                Text(
                                  "Forgot Password?",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: 'NTR',
                                      fontSize: 15,
                                      color: Color(0xff1A2375)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
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
                                .signInWithEmailAndPassword(
                                    email: _emailTextController.text,
                                    password: _passwordTextController.text)
                                .then((value) {
                              print("Logged In");
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage(
                                          title:
                                              'Trasheroo'))); //HomePage instead of resetpassword
                            }).onError((error, stackTrace) {
                              Navigator.pop(
                                  context); //to pop the loading circle
                              final _loginerrormessage = SnackBar(
                                content: Text(
                                  "An Error has occured during Login, Please Try Again!",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(240, 249, 250, 200)),
                                ),
                                backgroundColor:
                                    Color.fromARGB(255, 255, 21, 21),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(_loginerrormessage);
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
                                "Login",
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
                          height: 56,
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
