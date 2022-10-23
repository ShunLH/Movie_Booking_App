import 'package:json_annotation/json_annotation.dart';

import 'c_snack_vo.dart';
part 'checkout_request_vo.g.dart';
@JsonSerializable()
class CheckOutRequestVO{

  @JsonKey(name: "cinema_day_timeslot_id")
  int? cinemaDayTimeSlotId;
  @JsonKey(name: "seat_number")
  String? seatNumber;
  @JsonKey(name: "booking_date")
  String? bookingDate;
  @JsonKey(name: "movie_id")
  int? movieId;
  @JsonKey(name: "payment_type_id")
  int? paymentTypeId;
  @JsonKey(name: "snacks")
  List<CSnackVO>? snacks;


  CheckOutRequestVO(this.cinemaDayTimeSlotId, this.seatNumber, this.bookingDate,
      this.movieId, this.paymentTypeId, this.snacks);

  factory CheckOutRequestVO.fromJson(Map<String,dynamic> json) => _$CheckOutRequestVOFromJson(json);
  Map<String, dynamic> toJson() => _$CheckOutRequestVOToJson(this);
}

