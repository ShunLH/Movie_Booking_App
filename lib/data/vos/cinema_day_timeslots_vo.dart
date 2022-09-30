import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/timeslot_vo.dart';
part 'cinema_day_timeslots_vo.g.dart';
@JsonSerializable()
class CinemaDayTimeslotsVO {
  @JsonKey(name: "cinema_id")
  int? cinemaId;
  @JsonKey(name: "cinema")
  String? cinema;
  @JsonKey(name: "timeslots")
  List<TimeSlotVO>? timeslots;


  CinemaDayTimeslotsVO(this.cinemaId, this.cinema, this.timeslots);

  factory CinemaDayTimeslotsVO.fromJson(Map<String,dynamic> json) => _$CinemaDayTimeslotsVOFromJson(json);
  Map<String, dynamic> toJson() => _$CinemaDayTimeslotsVOToJson(this);
}