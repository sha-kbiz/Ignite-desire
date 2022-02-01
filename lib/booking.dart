//import 'package:desire/profile.dart';
import 'package:flutter/material.dart';
//import 'package:desire/services/auth.dart';
//import 'package:flutter_swiper/flutter_swiper.dart';
//import 'CardDetails.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

//final AuthService _auths = AuthService();

class _BookingState extends State<Booking> {
  // int _selectedIndex = 0;
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
  List<Widget> cardList = [];

  void removeCards(index) {
    setState(() {
      cardList.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    cardList = _generateCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.brown[50],
      // appBar: AppBar(
      //   title: const Text(
      //     'Ignite desire',
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   backgroundColor: Colors.red[400],
      //   elevation: 0.0,
      //   actions: <Widget>[
      //     FlatButton.icon(
      //       icon: const Icon(Icons.person),
      //       label:
      //           const Text('logout', style: TextStyle(color: Colors.white)),
      //       onPressed: () async {
      //         await _auths.signOut();
      //       },
      //     ),
      //   ],
      // ),

      //     body: SingleChildScrollView(
      //   padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      //   child: Column(
      //     children: const [
      //       Text('Booking page coming soon...'),
      //     ],
      //   ),
      // )
      body: Stack(alignment: Alignment.center, children: cardList),
    );
  }

  List<Widget> _generateCards() {
    List<PlanetCard> planetCard = [];
    planetCard.add(
      PlanetCard(
          "Mussorie",
          "https://www.tripsavvy.com/thmb/LTudD1VFIPILWGW5MoCsgBmhOGs=/650x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/464741705-56a3c03d5f9b58b7d0d39809.jpg",
          70.0),
    );
    planetCard.add(
      PlanetCard(
          "Manali ",
          "https://www.tripsavvy.com/thmb/YGzlP0l5lE79cah0LdH8sSWe7EI=/650x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-535240938-591c2d7b3df78cf5fa4919b5.jpg",
          80.0),
    );
    planetCard.add(PlanetCard(
        "Gangtok (Sikkim)",
        "https://www.tripsavvy.com/thmb/5X29hRjFEbE-5IYT3PFk30kqMZ4=/650x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-675923006-5a82469c3418c6003689af24.jpg",
        90.0));
    planetCard.add(PlanetCard(
        "Darjeeling (West Bengal)",
        "https://www.tripsavvy.com/thmb/xbATyZ6fE8sMFYDrDXU7P1wnbgE=/650x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-503908231-591be3103df78cf5fa000b74.jpg",
        100.0));
    planetCard.add(
      PlanetCard(
          "Nainital (Uttarakhand)",
          "http://amazingindiablog.in/wp-content/uploads/2015/06/P5035083.jpg",
          110.0),
    );
    List<Widget> cardList = [];

    for (int x = 0; x < 5; x++) {
      cardList.add(
        Positioned(
          top: planetCard[x].topMargin,
          child: Draggable(
              onDragEnd: (drag) {
                removeCards(x);
              },
              childWhenDragging: Container(),
              feedback: GestureDetector(
                onTap: () {
                  //print("Hello All");
                },
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  // color: Color.fromARGB(250, 112, 19, 179),
                  child: Column(
                    children: <Widget>[
                      Hero(
                        tag: "imageTag",
                        child: Image.network(
                          planetCard[x].cardImage,
                          width: 320.0,
                          height: 440.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(
                          planetCard[x].cardTitle,
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.purple,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              child: GestureDetector(
                child: Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    // color: Color.fromARGB(250, 112, 19, 179),
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0)),
                            image: DecorationImage(
                                image: NetworkImage(planetCard[x].cardImage),
                                fit: BoxFit.cover),
                          ),
                          height: 480.0,
                          width: 320.0,
                        ),
                        Container(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text(
                            planetCard[x].cardTitle,
                            style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.purple,
                            ),
                          ),
                        )
                      ],
                    )),
              )),
        ),
      );
    }
    return cardList;
  }
}

class PlanetCard {
  late String cardTitle;
  late String cardImage;
  late double topMargin;

  PlanetCard(String title, String imagePath, double marginTop) {
    cardTitle = title;
    cardImage = imagePath;
    topMargin = marginTop;
  }
}
