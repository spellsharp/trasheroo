import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
        child: Container(
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(20)
          // ),
          // width: MediaQuery.of(context).size.width * 0.8,
          color: Color.fromRGBO(11, 110, 79, 0.9),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 84.0,
                width: 305,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Text('Sidebar'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  print("pressed button1");
                },
                child: Text('Button 1'),
              ),
              ElevatedButton(
                onPressed: () {
                  print("pressed button2");
                },
                child: Text('Button 2'),
              ),
            ],
          ),
        ),
      );
}
