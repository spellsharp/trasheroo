import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'HomePage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  _launchKarti() async {
    Uri _url1 = Uri.parse('https://github.com/QuantuM410');
    if (await launchUrl(_url1)) {
      await launchUrl(_url1);
    } else {
      throw 'Could not launch $_url1';
    }
  }

  _launchGovinduu() async {
    Uri _url = Uri.parse('https://github.com/Viserion-7');
    if (await launchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }

  _launchSharan() async {
    Uri _url2 = Uri.parse('https://github.com/spellsharp');
    if (await launchUrl(_url2)) {
      await launchUrl(_url2);
    } else {
      throw 'Could not launch $_url2';
    }
  }

  _launchInsta() async {
    Uri _url2 = Uri.parse('https://www.instagram.com/amfoss.in/?hl=en');
    if (await launchUrl(_url2)) {
      await launchUrl(_url2);
    } else {
      throw 'Could not launch $_url2';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Expanded(
          child: Container(
            color: Color.fromRGBO(11, 110, 79, 1),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    color: Color.fromRGBO(0, 52, 36, 1),
                  ),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: GestureDetector(
                          child: Icon(
                            Icons.keyboard_backspace,
                            size: 30,
                            color: Colors.white,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyApp()),
                            );
                          }),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 65.0, top: 70),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/ByteForge.png'),
                  radius: 115,
                  backgroundColor: Colors.transparent,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 40.0, right: 25.0, top: 25.0),
                child: DefaultTextStyle(
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 18.0,
                    fontFamily: 'NTR',
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                  ),
                  child: Text(
                    "ByteForge is a mobile app development team run by first year members of amFOSS in Amrita Vishwa Vidhyapeetham, Amritapuri.",
                    textAlign: TextAlign.left,
                    maxLines: 5,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 38.0, left: 18.0, right: 18.0),
                child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.3),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 130.0, top: 10),
                child: DefaultTextStyle(
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'NTR',
                      fontSize: 20,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      decorationThickness: 1),
                  child: Text(
                    "Our Members",
                  ),
                ),
              ),
              SizedBox(height: 50),
              Row(
                children: [
                  SizedBox(width: 20),
                  DefaultTextStyle(
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'NTR',
                        fontWeight: FontWeight.w100),
                    child: GestureDetector(
                      child: Text("QuantuM410"),
                      onTap: () => _launchKarti(),
                    ),
                  ),
                  SizedBox(width: 40),
                  DefaultTextStyle(
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'NTR',
                        fontWeight: FontWeight.w100),
                    child: GestureDetector(
                      onTap: () => _launchSharan(),
                      child: Text("spellsharp"),
                    ),
                  ),
                  SizedBox(width: 40),
                  DefaultTextStyle(
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'NTR',
                        fontWeight: FontWeight.w100),
                    child: GestureDetector(
                      onTap: () => _launchGovinduu(),
                      child: Text("Viserion-7"),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 130.0),
                child: GestureDetector(
                  onTap: () => _launchInsta(),
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.instagram,
                          color: Colors.white, size: 40),
                      SizedBox(width: 10),
                      DefaultTextStyle(
                        style: TextStyle(color: Colors.white),
                        child: Text("@amfoss.in"),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
