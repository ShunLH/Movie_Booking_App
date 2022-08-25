import 'package:flutter/material.dart';
import 'package:movie_booking_app/assets.dart';
import 'package:movie_booking_app/pages/checkout_page.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/viewItems/fnb_sub_total_price_view.dart';
import 'package:movie_booking_app/viewItems/food_item_view.dart';
import 'package:movie_booking_app/viewItems/snack_bottom_sheet_view.dart';

import '../resources/colors.dart';
import '../resources/strings.dart';
import '../viewItems/app_bar_back_button_view.dart';

class FoodAndBeveragePage extends StatelessWidget {
  final List<String> _fnbList = [
    burger,
    burger1,
    mango,
    fruit,
    burger,
    burger1,
    mango,
    fruit,
  ];
  final List<String> _tabList = [
    "All",
    "Combo",
    "Snack",
    "Popcorn",
    "Beverage"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: Container(
          child: Text(
            "Grab a Bite",
            style: TextStyle(
              fontSize: TEXT_REGULAR_2X,
            ),
          ),
        ),
        leading: AppBarBackButtonView(() {
          Navigator.pop(context);
        }),
        actions: [
          Container(
            padding: EdgeInsets.all(MARGIN_SMALL),
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
            child: TextButton(
              onPressed: () => _navigateToCheckOutPage(context),
              child: Text(
                "SKIP",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Container(
                  child: DefaultTabController(
                    length: this._tabList.length,
                    child: Container(
                      color: Colors.white10,
                      child: TabBar(
                        labelColor: Colors.white,
                        indicatorColor: THEME_COLOR,
                        indicatorSize: TabBarIndicatorSize.label,
                        onTap: (index) {},
                        tabs: _tabList.map((item) => TabView(item)).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MARGIN_MEDIUM_2,
                ),
                Expanded(
                  child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: MARGIN_MEDIUM,
                      mainAxisSpacing: MARGIN_MEDIUM,
                      childAspectRatio: 0.8,
                      children: _fnbList
                          .map((fnbImgURL) => FoodItemView(
                                "item",
                                fnbImgURL,
                                "1500",
                                () => this._onTappedAddButton(context)
                              ))
                          .toList()),
                ),
              ],
            ),
          ),
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
                  this._navigateToCheckOutPage(context);
                },
                child: FnBBottomTotalPriceButtonView()
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onTappedAddButton(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckOutPage(),
        ));
  }

  void _navigateToCheckOutPage(BuildContext context) {
    showModalBottomSheet(context: context, builder: (context) => SnackBottomSheetView());

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
            fontSize: TEXT_SMALL,
          ),
        ),
      ),
    );
  }
}
