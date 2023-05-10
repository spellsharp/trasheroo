import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'Volunteer.dart';
import 'package:firebase_database/firebase_database.dart';

class ExploreCard extends StatefulWidget {
  final cardData;
  final cardDescription;
  final coordinates;
  const ExploreCard(
      {Key? key, this.cardData, this.cardDescription, this.coordinates})
      : super(key: key);

  @override
  State<ExploreCard> createState() => _ExploreCardState();
}

class _ExploreCardState extends State<ExploreCard> {
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
            ),
          ),
        );
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.cardData,
                              style: TextStyle(
                                  color: Color.fromRGBO(33, 42, 24, 1),
                                  fontSize: 18,
                                  fontFamily: 'NTR'),
                            ),
                            SizedBox(width: 10),
                            Text(
                              widget.cardDescription,
                              style: TextStyle(
                                  color: Color.fromRGBO(33, 42, 24, 1),
                                  fontSize: 14,
                                  fontFamily: 'NTR'),
                            ),
                            SizedBox(width: 10),
                            Text(
                              widget.coordinates,
                              style: TextStyle(
                                  color: Color.fromRGBO(33, 42, 24, 1),
                                  fontSize: 10,
                                  fontFamily: 'NTR'),
                            ),
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
  Explore({Key? key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  final TextEditingController _searchController = TextEditingController();
  late String heading;
  late String cardData;
  late String cardDescription;

  Map<String, Map<String, String>> _cardData = {
    'Card 1': {
      'Location': 'Kannur',
      'Description': 'Some description for Card 1',
      'Coordinate': '75.3704,11.8745',
    },
    'Card 2': {
      'Location': 'Amritapuri',
      'Description': 'Some description for Card 2',
      'Coordinate': '76.4896,9.0949',
    },
    'Card 3': {
      'Location': 'Chennai',
      'Description': 'Some description for Card 3',
      'Coordinate': '80.2707,13.0827',
    },
    'Card 4': {
      'Location': 'Mahe',
      'Description': 'Some description for Card 4',
      'Coordinate': '75.5343,11.7002',
    },
    'Card 5': {
      'Location': 'Ernakulam',
      'Description': 'Some description for Card 5',
      'Coordinate': '76.2999,9.9816',
    },
  };

  List<Widget> _cardDisplay() {
    List<Widget> cardList = [];

    _cardData.forEach((key, value) {
      if (value is Map<String, String>) {
        cardList.add(ExploreCard(
          cardData: "${value['Location']}",
          cardDescription: "${value['Description']}",
          coordinates: "${value['Coordinate']}",
        ));
      } else {
        cardList.add(ExploreCard(cardData: value));
      }
    });

    return cardList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromRGBO(243, 255, 166, 1),
      // backgroundColor: Color.fromARGB(48, 136, 255, 0),
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
                      onSubmitted: (value) {
                        print("Search requested");
                      },
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        // Add a clear button to the search bar
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () => _searchController.clear(),
                        ),
                        // Add a search icon or button to the search bar
                        prefixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            // Perform the search here
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
