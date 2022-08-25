import 'package:flutter/material.dart';
import 'package:movie_booking_app/pages/CinemaPage.dart';
import 'package:movie_booking_app/pages/profile_page.dart';
import 'package:movie_booking_app/pages/splash_screen.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';

import 'pages/home_page.dart';
import 'pages/tickets_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MovieApp(),
    );
  }
}

class MovieApp extends StatefulWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    CinemaPage(),
    TicketsPage(),
    ProfilePage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Container(
          margin: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.assistant_navigation,
                size: ICON_MEDIUM_SIZE,
              ),
              SizedBox(
                width: MARGIN_SMALL,
              ),
              Text(
                "Yangon",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: PRIMARY_COLOR,
        actions: [
          Container(
            padding: EdgeInsets.all(MARGIN_NORMAL),
            child: Icon(Icons.search_off_outlined),
          ),
          Container(
            padding: EdgeInsets.all(MARGIN_NORMAL),
            child: Icon(Icons.notifications),
          ),
          Container(
            padding: EdgeInsets.all(MARGIN_NORMAL),
            child: Icon(Icons.qr_code_scanner),
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: PRIMARY_COLOR,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle),
            label: 'Movies',
            backgroundColor: PRIMARY_COLOR,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_stable_rounded),
            label: 'Cinema',
            backgroundColor: PRIMARY_COLOR,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle),
            label: 'Tickets',
            backgroundColor: PRIMARY_COLOR,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: PRIMARY_COLOR,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: THEME_COLOR,
        onTap: _onItemTapped,
      ),
    );
  }
}
