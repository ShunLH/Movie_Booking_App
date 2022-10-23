import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/c_snack_vo.dart';
import 'package:movie_booking_app/data/vos/timeslot_vo.dart';
part 'ticket_vo.g.dart';
@JsonSerializable()
class TicketVO{
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "booking_no")
  String? bookingNo;
  @JsonKey(name: "booking_date")
  String? bookingDate;
  @JsonKey(name: "row")
  String? row;
  @JsonKey(name: "seat")
  String? seat;
  @JsonKey(name: "total_seat")
  int? totalSeat;
  @JsonKey(name: "total")
  String? total;
  @JsonKey(name: "movie_id")
  int? movie_id;
  @JsonKey(name: "cinema_id")
  int? cinema_id;
  @JsonKey(name: "username")
  String? username;
  @JsonKey(name: "timeslot")
  TimeSlotVO? timeslot;
  @JsonKey(name: "snacks")
  List<CSnackVO>? snacks;
  @JsonKey(name: "qr_code")
  String? qrCode;

  TicketVO(
      this.id,
      this.bookingNo,
      this.bookingDate,
      this.row,
      this.seat,
      this.totalSeat,
      this.total,
      this.movie_id,
      this.cinema_id,
      this.username,
      this.timeslot,
      this.snacks,
      this.qrCode);

  factory TicketVO.fromJson(Map<String,dynamic> json) => _$TicketVOFromJson(json);
  Map<String, dynamic> toJson() => _$TicketVOToJson(this);
}