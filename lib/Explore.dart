import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'Volunteer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';
import 'dart:typed_data';

class ExploreCard extends StatefulWidget {
  final cardData;
  final cardDescription;
  final coordinates;
  final id;
  final image64;
  ExploreCard({
    Key? key,
    this.cardData,
    this.cardDescription,
    this.coordinates,
    this.id,
    this.image64,
  }) : super(key: key);

  @override
  State<ExploreCard> createState() => _ExploreCardState();
}

class _ExploreCardState extends State<ExploreCard> {
  render_image(imageEncoded) {
    Uint8List bytes = base64Decode(imageEncoded);
    return Image.memory(
      bytes,
      fit: BoxFit.cover,
      height: 143.0,
      width: 337.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Volunteer(
              cardData: widget.cardData,
              cardDescription: widget.cardDescription,
              coordinates: widget.coordinates,
              image: widget.image64,
              id: widget.id,
            ),
          ),
        );
        // print(widget.image64);
      }),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Color.fromRGBO(0, 24, 2, 0.498),
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              height: 161,
              width: 337,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color.fromRGBO(152, 183, 111, 0.8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(145, 167, 141, 0.494),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                      ),
                    ),
                    child: Text(
                      "#" + widget.id,
                      style: TextStyle(
                        color: Color.fromRGBO(33, 42, 24, 1),
                        fontSize: 10,
                        height: 1.5,
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Opacity(
                        opacity: 0.5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          child: render_image(widget.image64),
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 5),
                                Text(
                                  widget.cardData,
                                  style: TextStyle(
                                      color: Color.fromRGBO(33, 42, 24, 1),
                                      fontSize: 20,
                                      fontFamily: 'NTR'),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  widget.cardDescription,
                                  style: TextStyle(
                                      color: Color.fromRGBO(33, 42, 24, 1),
                                      fontSize: 16,
                                      fontFamily: 'NTR'),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  widget.coordinates,
                                  style: TextStyle(
                                      color: Color.fromRGBO(33, 42, 24, 1),
                                      fontSize: 12,
                                      fontFamily: 'NTR'),
                                ),
                              ],
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class Explore extends StatefulWidget {
  final Map<String, Map<String, String>> postDataMap;
  Explore({
    Key? key,
    required this.postDataMap,
  });

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  final TextEditingController _searchController = TextEditingController();
  late String heading;
  late String cardData;
  late String cardDescription;

  List<Widget> _cardDisplay() {
    List<Widget> cardList = [];

    widget.postDataMap.forEach((key, value) {
      if (value is Map<String, String>) {
        cardList.add(ExploreCard(
          cardData: "${value['location']}",
          cardDescription: "${value['description']}",
          coordinates: "${value['coordinates']}",
          id: "${value['id']}",
          image64: "${value['image']}",
        ));
      } else {
        cardList.add(ExploreCard(cardData: value));
      }
    });

    return filteredList.isNotEmpty ? filteredList : cardList;
  }

  List<Widget> filteredList = [];

  void _filterList(String searchText) {
    filteredList.clear();

    if (searchText.isEmpty) {
      setState(() {
        filteredList.addAll(_cardDisplay());
      });
    } else {
      setState(
        () {
          widget.postDataMap.forEach(
            (key, value) {
              if (value is Map<String, String>) {
                if (value['location']!
                    .toLowerCase()
                    .contains(searchText.toLowerCase())) {
                  filteredList.add(
                    ExploreCard(
                      cardData: "${value['location']}",
                      cardDescription: "${value['description']}",
                      coordinates: "${value['coordinates']}",
                      id: "${value['id']}",
                      image64: "${value['image']}",
                    ),
                  );
                }
              }
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 255, 166, 1),
      body: Container(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      onChanged: _filterList,
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () => _searchController.clear(),
                        ),
                        prefixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            print("Search button clicked");
                          },
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  if (filteredList.isEmpty == true &&
                      _searchController.text.isNotEmpty)
                    Text(
                      "No results found",
                      style: TextStyle(
                        color: Color.fromRGBO(33, 42, 24, 1),
                        fontSize: 20,
                        fontFamily: 'NTR',
                      ),
                    ),
                  ..._cardDisplay(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
