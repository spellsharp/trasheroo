import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          color: Color.fromRGBO(11, 110, 79, 0.9),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sidebar'),
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
