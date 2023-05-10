import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'Login_Page.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController _emailTextController = TextEditingController();
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
                            "Reset Password",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 34,
                              fontFamily: 'NTR',
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
                        SizedBox(height: 50),
                        GestureDetector(
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );
                            try {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(
                                      email: _emailTextController.text.trim());
                              final _recoverymessage = SnackBar(
                                content: Text(
                                  "The Recovery E-mail has been sent!",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 61, 8)),
                                ),
                                backgroundColor: Colors.lightGreenAccent,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(_recoverymessage);
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            } on FirebaseAuthException catch (e) {
                              Navigator.pop(context);
                              final _recoverymessage = SnackBar(
                                content: Center(
                                  child: Text(
                                    "Email-Id not found ! Try Again ",
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(255, 255, 255, 1)),
                                  ),
                                ),
                                backgroundColor: Color.fromARGB(255, 255, 8, 8),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(_recoverymessage);
                            }
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
                                "Send e-mail",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontFamily: 'NTR',
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 45),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "*If your email is linked to an account, you’ll   receive a mail for resetting your password.",
                            style: TextStyle(
                              fontFamily: 'NTR',
                              fontSize: 16,
                              height: 1,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          "Contact Us: +91 7454339241",
                          style: TextStyle(
                            fontFamily: 'NTR',
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 55,
                        ),
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
