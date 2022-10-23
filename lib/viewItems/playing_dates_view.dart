import 'package:flutter/material.dart';
import '../data/vos/movie_date_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/dummy.dart';

class PlayingDatesView extends StatelessWidget {
  final bool isSelected;
  final MovieDateVO dateVO;
  Function onTappedDate;
  PlayingDatesView(this.dateVO, this.isSelected, this.onTappedDate);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTappedDate(),
      child: Container(
        padding: EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width * 0.23,
        color: PRIMARY_COLOR,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? THEME_COLOR : DARK_GRAY_TEXT_COLOR,
                  borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.all(MARGIN_SMALL),
                width: 20,
                height: 4,
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR,
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 5,
                height: 10,
                margin: EdgeInsets.only(bottom: MARGIN_MEDIUM),
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 5,
                height: 10,
                margin: EdgeInsets.only(bottom: MARGIN_MEDIUM),
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MARGIN_XSMALL, vertical: MARGIN_MEDIUM),
                child: DateTextView(this.dateVO),
              ),
            )
          ],
        ),
      ),
    );
  }
}
class DateTextView extends StatelessWidget {
  final MovieDateVO date;
  DateTextView(this.date);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          this.date.title,
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontSize: TEXT_CARD_SMALL,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: MARGIN_SMALL),
        Text(
          this.date.month,
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontSize: TEXT_CARD_SMALL,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: MARGIN_XSMALL),
        Text(
          this.date.day,
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontSize: TEXT_CARD_SMALL,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}