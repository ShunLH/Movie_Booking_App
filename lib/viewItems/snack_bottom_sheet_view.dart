import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';

import 'fnb_sub_total_price_view.dart';

class FoodItem {
  String name;
  int price;

  FoodItem(this.name,this.price);
}

class SnackBottomSheetView extends StatelessWidget {

  List<FoodItem> foodItemList = [
    FoodItem("Coca Cola", 1000),
    FoodItem("Potato Chips", 1200),
    FoodItem("Burger Combo", 5000)
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM,vertical: MARGIN_MEDIUM_2),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.9),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(MARGIN_CARD_MEDIUM_1),topRight: Radius.circular(MARGIN_CARD_MEDIUM_1))
      ),
      height: 300,
      child: Column(
        children: [
          Column(
            children: foodItemList.map((item) => FoodItemRowView(item.name, item.price)).toList()
          ),
          SizedBox(height: MARGIN_MEDIUM_2,),
          FnBBottomTotalPriceButtonView()
        ],
      ),
    );
  }
}

class FoodItemRowView extends StatefulWidget {
  final String itemName;
  final int itemPrice;

  FoodItemRowView(this.itemName, this.itemPrice);
  @override
  State<FoodItemRowView> createState() => _FoodItemRowViewState();
}

class _FoodItemRowViewState extends State<FoodItemRowView> {
  var _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ItemNameTextView(this.widget.itemName),
        Spacer(),
        CirclePlusButtonView(() {
          setState(() {
            _quantity = _quantity + 1;
          });
        }),
        SizedBox(
          width: MARGIN_CARD_MEDIUM_1,
        ),
        ItemCountTextView(_quantity),
        CircleMinusButtonView(() {
          setState(() {
            _quantity = _quantity > 0 ? _quantity - 1 : _quantity;
          });
        }),
        Spacer(),
        ItemPriceTextView(this.widget.itemPrice * this._quantity),
      ],
    );
  }
}

class ItemCountTextView extends StatelessWidget {
  final int count;

  ItemCountTextView(this.count);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$count",
      style: TextStyle(
        color: THEME_COLOR,
        fontSize: TEXT_CARD_SMALL,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class ItemPriceTextView extends StatelessWidget {
  final int price;
  ItemPriceTextView(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      alignment: Alignment.centerRight,
      child: Text(
        "$price Ks",
        style: TextStyle(
          color: Colors.white,
          fontSize: TEXT_REGULAR_2X,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ItemNameTextView extends StatelessWidget {
  final String itemName;

  ItemNameTextView(this.itemName);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Expanded(
        child: Text(
          itemName,
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

class CirclePlusButtonView extends StatelessWidget {
  Function onTappedPlus;
  CirclePlusButtonView(this.onTappedPlus);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        shape: CircleBorder(),
        primary: THEME_COLOR, // <-- Button color
        onPrimary: PRIMARY_COLOR, // <-- Splash color
      ),
      onPressed: () => this.onTappedPlus(),
      child: Icon(Icons.add, color: Colors.white,),
    );
  }
}

class CircleMinusButtonView extends StatelessWidget {
  Function onTappedRemove;
  CircleMinusButtonView(this.onTappedRemove);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        shape: CircleBorder(),
        primary: THEME_COLOR, // <-- Button color
        onPrimary: PRIMARY_COLOR, // <-- Splash color
      ),
      onPressed: () => this.onTappedRemove(),
      child: Icon(Icons.remove, color: Colors.white,),
    );
  }
}
