import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/dummy.dart';

import '../viewItems/profile_menu_item_view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 240,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        "assets/images/cinema_background.png",
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
                        child: LoginColumnView(),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: MARGIN_SMALL),
              Container(
                child: MenuListView(() => {}),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuListView extends StatelessWidget {
  Function onTappedMenu;
  MenuListView(this.onTappedMenu);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: itemList.length,
        itemBuilder: (BuildContext context, int index) {
          return ProfileMenuItemView(itemList[index], () => this.onTappedMenu());
        }
    );
  }
}

class LoginColumnView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/images/profile-circled.png",
            fit: BoxFit.fitWidth,
            width: MediaQuery.of(context).size.width * 0.3),
        SizedBox(height: MARGIN_SMALL),
        LoginButtonView()
      ],
    );
  }
}

class LoginButtonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.45,
        height: BOOKING_BTN_HEIGHT,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL)),
            border: Border.all(
                color: THEME_COLOR, width: 1.0, style: BorderStyle.solid)),
        child: TextButton(
          onPressed: () => {},
          child: Text(
            "Login or Sign Up",
            style: TextStyle(
                color: THEME_COLOR,
                fontWeight: FontWeight.bold,
                fontSize: TEXT_REGULAR),
          ),
        ));
  }
}
