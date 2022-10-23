import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/models/data_repository.dart';
import 'package:movie_booking_app/data/models/movie_model.dart';
import 'package:movie_booking_app/data/models/movie_model_impl.dart';
import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/data/vos/snack_category_vo.dart';
import 'package:movie_booking_app/data/vos/snack_vo.dart';
import 'package:movie_booking_app/data/vos/timeslot_vo.dart';
import 'package:movie_booking_app/pages/checkout_page.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/strings.dart';
import 'package:movie_booking_app/viewItems/fnb_sub_total_price_view.dart';
import 'package:movie_booking_app/viewItems/food_item_view.dart';
import 'package:movie_booking_app/viewItems/snack_bottom_sheet_view.dart';

import '../data/vos/cinema_day_timeslots_vo.dart';
import '../data/vos/date_vo.dart';
import '../data/vos/movie_vo.dart';
import '../resources/colors.dart';
import '../widgets/app_bar_back_button_view.dart';

class FoodAndBeveragePage extends StatefulWidget {
  final MovieVO? mMovie;
  final CinemaVO? mCinema;
  final CinemaDayTimeslotsVO? mCinemaTimeSlot;
  final TimeSlotVO? cinemaDayTimeSlot;
  final String? bookingDate;
  FoodAndBeveragePage(this.mMovie, this.mCinema, this.mCinemaTimeSlot,this.cinemaDayTimeSlot,this.bookingDate);
  @override
  State<FoodAndBeveragePage> createState() => _FoodAndBeveragePageState();
}

class _FoodAndBeveragePageState extends State<FoodAndBeveragePage> {
  DataRepository dataRepository = DataRepository();
  MovieModel mMovieModel = MovieModelImpl();
  List<SnackVO>? mSncaksList;
  List<SnackCategoryVO>? mSncakCategoriesList;
  Set<SnackVO>? orderedSnacksList = {};
  int totalPrice = 0;

  @override
  void initState() {
    super.initState();
    SnackCategoryVO allCategories =
        SnackCategoryVO(null, "All", "All Categories", 0, "", "", "");
    mMovieModel
        .getSnackCategoriesList(mMovieModel.getTokenFromDatabase())
        ?.then((snackCategories) {
      setState(() {
        mSncakCategoriesList = snackCategories;
        mSncakCategoriesList?.insert(0, allCategories);
        _getSnackListByCategory(null);
      });
    });

    mMovieModel
        .getSnackCategoriesListFromDatabase()
        ?.then((snackCategories) {
      setState(() {
        mSncakCategoriesList = snackCategories;
        mSncakCategoriesList?.insert(0, allCategories);
        _getSnackListByCategory(null);
      });
    });
  }

  void _getSnackListByCategory(int? categoryId) {
    mMovieModel
        .getSnacksList(mMovieModel.getTokenFromDatabase(), categoryId)
        ?.then((snacksList) {
      setState(() {
        mSncaksList = snacksList;
      });
    });
    mMovieModel
        .getSnacksListFromDatabase(categoryId)
        ?.then((snacksList) {
      setState(() {
        mSncaksList = snacksList;
      });
    });
  }

  void _calcTotalPrice() {
    int total = 0;
    this.orderedSnacksList?.forEach((element) {
      total += (element.price ?? 0) * (element.quantity ?? 1);
    });
    setState(() {
      totalPrice = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: SnackTitleTextView(),
        leading: AppBarBackButtonView(() {
          Navigator.pop(context);
        }),
        actions: [
          SearchActionView(),
          SkipActionView(() => _navigateToCheckOutPage(context)),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            (this.mSncakCategoriesList != null)
                ? SnacksTabBarView(this.mSncakCategoriesList!, (categoryId) {
                    print("id ${categoryId}");
                    setState(() {
                      this._getSnackListByCategory(categoryId);
                    });
                  })
                : Container(),
            SizedBox(
              height: MARGIN_MEDIUM_2,
            ),
            (mSncaksList != null)
                ? Expanded(
                    child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 0.85,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        itemCount: mSncaksList?.length ?? 0,
                        itemBuilder: (BuildContext context, index) {
                          return FoodItemView(mSncaksList?[index], (snack) {
                            setState(() {
                              snack.quantity = (snack.quantity ?? 0) + 1;
                              this.orderedSnacksList?.add(snack);
                            });
                            _calcTotalPrice();
                            this._onTappedAddButton(context);
                          });
                        }))
                : Container(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(MARGIN_MEDIUM),
                width: MediaQuery.of(context).size.width,
                height: FNB_BOTTOM_VIEW_HEIGHT,
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR,
                ),
                child: GestureDetector(
                    onTap: () {
                      this._onTappedAddButton(context);
                    },
                    child: FnBBottomTotalPriceButtonView(totalPrice,() {
                      this._navigateToCheckOutPage(context);
                    })),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _navigateToCheckOutPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckOutPage(
            mMovie: this.widget.mMovie,
            mCinema: this.widget.mCinema,
            mSnackList: this.orderedSnacksList?.toList(),
            mCinemaTimeSlot: this.widget.mCinemaTimeSlot,
            cinemaTimeSlot: this.widget.cinemaDayTimeSlot,
            bookingDate: this.widget.bookingDate,
          ),
        ));
  }

  void _onTappedAddButton(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => SnackBottomSheetView(
            this.orderedSnacksList?.toList() ?? [], onChangeQuantity: () => _calcTotalPrice(),onTappedContinueButton: () => _navigateToCheckOutPage(context),));
  }
}

class SkipActionView extends StatelessWidget {
  Function onTappedSkip;

  SkipActionView(this.onTappedSkip);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
      child: TextButton(
        onPressed: () => this.onTappedSkip(),
        child: Text(
          SKIP,
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class SearchActionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MARGIN_SMALL),
      child: Icon(
        Icons.search,
        color: Colors.white,
      ),
    );
  }
}

class SnackTitleTextView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "Grab a Bite",
        style: TextStyle(
          fontSize: TEXT_REGULAR_2X,
        ),
      ),
    );
  }
}

class SnacksTabBarView extends StatelessWidget {
  Function(int) onTapCategory;
  final List<SnackCategoryVO> _categoriesList;
  SnacksTabBarView(this._categoriesList, this.onTapCategory);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: this._categoriesList.length,
        child: Container(
          color: Colors.white10,
          child: TabBar(
            labelColor: Colors.white,
            indicatorColor: THEME_COLOR,
            indicatorSize: TabBarIndicatorSize.tab,
            onTap: (index) {
              this.onTapCategory(_categoriesList[index].id ?? 0);
            },
            tabs: _categoriesList
                .map((category) => TabView(category.title ?? ""))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class TabView extends StatelessWidget {
  final String title;
  TabView(this.title);
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
