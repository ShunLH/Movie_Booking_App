import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/models/movie_model_impl.dart';
import 'package:movie_booking_app/data/vos/banner_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_day_timeslots_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_timeslot_status_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/data/vos/city_vo.dart';
import 'package:movie_booking_app/data/vos/config_data_vo.dart';
import 'package:movie_booking_app/data/vos/facility_vo.dart';
import 'package:movie_booking_app/data/vos/movie_date_timeslots_vo.dart';
import 'package:movie_booking_app/data/vos/payment_type_vo.dart';
import 'package:movie_booking_app/data/vos/snack_category_vo.dart';
import 'package:movie_booking_app/data/vos/timeslot_vo.dart';
import 'package:movie_booking_app/network/dataagents/retrofit_data_agent_impl.dart';
import 'package:movie_booking_app/pages/promo_video_player_view.dart';
import 'package:movie_booking_app/pages/cinema_page.dart';
import 'package:movie_booking_app/pages/login_page.dart';
import 'package:movie_booking_app/pages/movie_search_view.dart';
import 'package:movie_booking_app/pages/profile_page.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/widgets/image_icon_view.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/models/movie_model.dart';
import 'data/vos/collection_vo.dart';
import 'data/vos/credit_vo.dart';
import 'data/vos/date_vo.dart';
import 'data/vos/genre_vo.dart';
import 'data/vos/movie_vo.dart';
import 'data/vos/production_companies_vo.dart';
import 'data/vos/production_countries_vo.dart';
import 'data/vos/snack_vo.dart';
import 'data/vos/spoken_languages_vo.dart';
import 'data/vos/user_vo.dart';
import 'pages/home_page.dart';
import 'pages/tickets_page.dart';

void main() async{
  await Hive.initFlutter();

  Hive.registerAdapter(UserVOAdapter());
  Hive.registerAdapter(BannerVOAdapter());
  Hive.registerAdapter(CinemaVOAdapter());
  Hive.registerAdapter(CityVOAdapter());
  Hive.registerAdapter(CollectionVOAdapter());
  Hive.registerAdapter(CreditVOAdapter());
  Hive.registerAdapter(DateVOAdapter());
  Hive.registerAdapter(GenreVOAdapter());
  Hive.registerAdapter(MovieVOAdapter());
  Hive.registerAdapter(ProductionCompaniesVOAdapter());
  Hive.registerAdapter(ProductionCountriesVOAdapter());
  Hive.registerAdapter(SpokenLanguagesVOAdapter());
  Hive.registerAdapter(SnackCategoryVOAdapter());
  Hive.registerAdapter(SnackVOAdapter());
  Hive.registerAdapter(FacilityVOAdapter());
  Hive.registerAdapter(PaymentTypeVOAdapter());
  Hive.registerAdapter(TimeSlotVOAdapter());
  Hive.registerAdapter(CinemaDayTimeslotsVOAdapter());
  Hive.registerAdapter(ConfigDataVOAdapter());
  Hive.registerAdapter(MovieDateTimeSlotsVOAdapter());
  Hive.registerAdapter(CinemaTimeSlotStatusVOAdapter());
  //
  await Hive.openBox<UserVO>(BOX_NAME_USER_VO);
  await Hive.openBox<BannerVO>(BOX_NAME_BANNER_VO);
  await Hive.openBox<MovieVO>(BOX_NAME_MOVIE_VO);
  await Hive.openBox<CreditVO>(BOX_NAME_CREDIT_VO);
  await Hive.openBox<GenreVO>(BOX_NAME_GENRE_VO);
  await Hive.openBox<CinemaVO>(BOX_NAME_CINEMA_VO);
  await Hive.openBox<CityVO>(BOX_NAME_CITY_VO);
  await Hive.openBox<SnackCategoryVO>(BOX_NAME_SNACK_CATEGORY_VO);
  await Hive.openBox<SnackVO>(BOX_NAME_SNACK_VO);
  await Hive.openBox<PaymentTypeVO>(BOX_NAME_PAYMENT_TYPE_VO);
  await Hive.openBox<ConfigDataVO>(BOX_NAME_CONFIG_DATA_VO);
  await Hive.openBox<MovieDateTimeSlotsVO>(BOX_NAME_MOVIE_DATE_TIMESLOTS_VO);
  await Hive.openBox<CinemaTimeSlotStatusVO>(BOX_NAME_CINEMA_TIMESLOT_STATUS_VO);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MovieModelImpl movieModel = MovieModelImpl();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (movieModel.mUserDao.getAllUsers().isEmpty) ? LoginPage() : MovieApp(city:movieModel.getLoginUser()?.selectedCity),
      // home : LoginPage()
    );
  }
}

class MovieApp extends StatefulWidget {
  final CityVO? city;

  MovieApp({required this.city});

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
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
  void initState() {
    super.initState();
    print("city ${this.widget.city?.name}");
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
                "${this.widget.city?.name ?? "Ygn"}",
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
            onTap: () {
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
            activeIcon:
                const ImageIcon(AssetImage("assets/images/play_video.png")),
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
        selectedItemColor: ConfigClass.themeColor,
        onTap: _onItemTapped,
      ),
    );
  }

  void _navigateToSearchMovieListView(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieSearchView(),
        ));
  }
}
