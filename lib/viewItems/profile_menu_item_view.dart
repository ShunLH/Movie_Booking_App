import 'package:flutter/material.dart';
import 'package:movie_booking_app/pages/movie_time_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/widgets/image_icon_view.dart';
import '../resources/dimens.dart';


class ProfileMenu {
  String name;
  String imgName;
  ProfileMenu(this.name,this.imgName);
}

class ProfileMenuItemView extends StatelessWidget {

  final ProfileMenu item;
  Function onTappedItem;

  ProfileMenuItemView(this.item,this.onTappedItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      padding: EdgeInsets.symmetric(vertical: MARGIN_XSMALL),
      child: GestureDetector(
        onTap: () => this.onTappedItem(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
          child: Column(
            children: [
              Row(
                children: [
                  ImageIconView(item.imgName,ICON_MEDIUM_SIZE,Colors.white,),
                  SizedBox(width: MARGIN_SMALL),
                  Text(item.name,style: TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_REGULAR,
                    fontWeight: FontWeight.bold
                  ),),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios,color: DARK_GRAY_TEXT_COLOR,size: ICON_SMALL_SIZE)
                ],
              ),
              SizedBox(height: MARGIN_MEDIUM),
              SepartorLineView(STATUS_SECTION_COLOR)
            ],
          ),
        ),
      ),
    );
  }
}
