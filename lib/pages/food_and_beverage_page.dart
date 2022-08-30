import 'package:flutter/material.dart';
import 'package:movie_booking_app/assets.dart';
import 'package:movie_booking_app/pages/checkout_page.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/viewItems/fnb_sub_total_price_view.dart';
import 'package:movie_booking_app/viewItems/food_item_view.dart';
import 'package:movie_booking_app/viewItems/snack_bottom_sheet_view.dart';

import '../resources/colors.dart';
import '../resources/strings.dart';
import '../widgets/app_bar_back_button_view.dart';

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
            SnacksTabBarView(),
            SizedBox(
              height: MARGIN_MEDIUM_2,
            ),
            Expanded(
              child: GridView.builder(
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 0.85,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: _fnbList.length,
                  itemBuilder: (BuildContext context, index) {
                    return FoodItemView("item",_fnbList[index], "1500",
                            () => this._onTappedAddButton(context));
                  }),
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
                      this._onTappedAddButton(context);
                    },
                    child: FnBBottomTotalPriceButtonView()),
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
          builder: (context) => CheckOutPage(),
        ));
  }

  void _onTappedAddButton(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
        context: context, builder: (context) => SnackBottomSheetView());
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
          "SKIP",
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
  const SearchActionView({
    Key? key,
  }) : super(key: key);

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
  const SnackTitleTextView({
    Key? key,
  }) : super(key: key);

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

  final List<String> _tabList = [
    "All",
    "Combo",
    "Snack",
    "Popcorn",
    "Beverage"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: this._tabList.length,
        child: Container(
          color: Colors.white10,
          child: TabBar(
            labelColor: Colors.white,
            indicatorColor: THEME_COLOR,
            indicatorSize: TabBarIndicatorSize.tab,
            onTap: (index) {},
            tabs: _tabList.map((item) => TabView(item)).toList(),
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
