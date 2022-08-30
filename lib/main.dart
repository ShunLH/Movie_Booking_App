import 'package:flutter/material.dart';
import 'package:movie_booking_app/pages/CinemaPage.dart';
import 'package:movie_booking_app/pages/login_page.dart';
import 'package:movie_booking_app/pages/movie_search_view.dart';
import 'package:movie_booking_app/pages/profile_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/widgets/image_icon_view.dart';

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
      home: LoginPage(),
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Container(
          margin: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ImageIconView(
                  "navigation_white.png", ICON_MEDIUM_SIZE, Colors.white),
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
          GestureDetector(
            onTap: (){
              this._navigateToSearchMovieListView(context);
            },
            child: Container(
              padding: const EdgeInsets.all(MARGIN_NORMAL),
              child: Icon(Icons.search),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(MARGIN_NORMAL),
            child: Icon(Icons.notifications),
          ),
          Container(
            child: ImageIconView("qr_scanner.png", 60, Colors.white),
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: PRIMARY_COLOR,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const ImageIcon(AssetImage("assets/images/play_video.png")),
            activeIcon: const ImageIcon(AssetImage("assets/images/play_video.png")),
            label: 'Movies',
            backgroundColor: PRIMARY_COLOR,
          ),
          BottomNavigationBarItem(
            icon: const ImageIcon(AssetImage("assets/images/cinema.png")),
            activeIcon: const ImageIcon(AssetImage("assets/images/cinema.png")),
            label: 'Cinema',
            backgroundColor: PRIMARY_COLOR,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/images/tickets.png")),
            activeIcon: ImageIcon(AssetImage("assets/images/tickets.png")),
            label: 'Tickets',
            backgroundColor: PRIMARY_COLOR,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            activeIcon: Icon(Icons.person),
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
  void _navigateToSearchMovieListView(BuildContext context){
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieSearchView(),
        ));
  }
}
