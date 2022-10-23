import 'package:flutter/material.dart';
import 'package:movie_booking_app/viewItems/profile_menu_item_view.dart';



enum AvaliableStatus { AVALIABLE, FILLING_FAST, ALMOST_FULL, NOT_AVALIABLE }

class MovieTimeSlotVO {
  String time;
  String cinemaType;
  String screenType;
  AvaliableStatus avaliableStatus;
  int avaliableCount;

  MovieTimeSlotVO(this.time, this.cinemaType, this.screenType,
      this.avaliableStatus, this.avaliableCount);
}

// final List<MovieTimeSlotVO> movieTimeSlotList = [
//   MovieTimeSlotVO(
//       "9:30 AM", "3D", "Screen 1", AvaliableStatus.NOT_AVALIABLE, 0),
//   MovieTimeSlotVO(
//       "12:30 PM", "3D Max", "Screen 1", AvaliableStatus.AVALIABLE, 21),
//   MovieTimeSlotVO("12:30 AM", "3D", "Screen 2", AvaliableStatus.ALMOST_FULL, 2),
//   MovieTimeSlotVO("3:30 AM", "3D", "Screen 2", AvaliableStatus.AVALIABLE, 23),
//   MovieTimeSlotVO(
//       "6:30 AM", "3D", "Screen 2", AvaliableStatus.FILLING_FAST, 21),
// ];

final List<ProfileMenu> itemList = [
  ProfileMenu("Purchase History", "purchase_history.png"),
  ProfileMenu("Offer", "offer.png"),
  ProfileMenu("Gift Card", "gift_card.png"),
  ProfileMenu("Payment", "payment.png"),
  ProfileMenu("Help and Support", "info_icon.png"),
  ProfileMenu("Logout", "logout.png"),

];
