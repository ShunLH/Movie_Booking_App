import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/colors.dart';

class CornerSeparator extends StatelessWidget {
  final double size;
  final Color bgColor;
  CornerSeparator(this.size,this.bgColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      color: bgColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(topRight: Radius.circular(size/2),bottomRight: Radius.circular(size/2)),
            ),
          ),
          Container(color: this.bgColor,height: 30, child: Align(alignment:Alignment.center,child: SeparatorView(size))),
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(size/2),bottomLeft: Radius.circular(size/2)),
            ),
          ),
        ],
      ),
    );
  }
}

class SeparatorView extends StatelessWidget {
  final double cornerSize;
  SeparatorView(this.cornerSize);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - cornerSize * 2,
      height: 2,
      color: Colors.white24,
    );
  }
}