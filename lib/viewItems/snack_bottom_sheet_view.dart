import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/vos/snack_vo.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';

import 'fnb_sub_total_price_view.dart';

class SnackBottomSheetView extends StatefulWidget {

  final List<SnackVO> foodItemList;
  Function onChangeQuantity;
  SnackBottomSheetView(this.foodItemList,this.onChangeQuantity);

  @override
  State<SnackBottomSheetView> createState() => _SnackBottomSheetViewState();
}

class _SnackBottomSheetViewState extends State<SnackBottomSheetView> {
  int totalPrice = 0;

  @override
  void initState() {
    super.initState();
    totalPrice = _calcTotalPrice();
  }

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
            children: widget.foodItemList.map((item) => FoodItemRowView(item,(){
              setState(() => totalPrice = _calcTotalPrice());
              this.widget.onChangeQuantity();
            })).toList()
          ),
          SizedBox(height: MARGIN_MEDIUM_2,),
          FnBBottomTotalPriceButtonView(totalPrice)
        ],
      ),
    );
  }

  int _calcTotalPrice(){
    int total = 0;
   this.widget.foodItemList.forEach((element) {
     total += (element.price ?? 0) * (element.quantity ?? 1);
   });
   return total;
  }
}

class FoodItemRowView extends StatefulWidget {

  final SnackVO? mSnack;
  Function onChangeQuantity;

  FoodItemRowView(this.mSnack,this.onChangeQuantity);
  @override
  State<FoodItemRowView> createState() => _FoodItemRowViewState();
}

class _FoodItemRowViewState extends State<FoodItemRowView> {
  var _quantity = 1;
  @override
  void initState() {
    super.initState();
    _quantity = widget.mSnack?.quantity ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 86,child: ItemNameTextView(this.widget.mSnack?.name ?? "")),
        Spacer(),
        CirclePlusButtonView(() {
          setState(() {
            _quantity = _quantity + 1;
            widget.mSnack?.quantity = _quantity;
            this.widget.onChangeQuantity();
          });
        }),
        SizedBox(
          width: MARGIN_CARD_MEDIUM_1,
        ),
        ItemCountTextView(_quantity),
        CircleMinusButtonView(() {
          setState(() {
            _quantity = _quantity > 0 ? _quantity - 1 : _quantity;
            this.widget.onChangeQuantity();
          });
        }),
        Spacer(),
        ItemPriceTextView((this.widget.mSnack?.price ?? 0) * (this.widget.mSnack?.quantity ?? 1)),
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
    return Text(
      itemName,
      style: TextStyle(
        color: Colors.white,
        fontSize: TEXT_REGULAR,
        fontWeight: FontWeight.bold,
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
