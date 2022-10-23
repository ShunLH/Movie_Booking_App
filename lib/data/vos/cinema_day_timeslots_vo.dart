import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/timeslot_vo.dart';

import '../../persistence/hive_constants.dart';
import 'date_vo.dart';
part 'cinema_day_timeslots_vo.g.dart';

@HiveType(typeId: HYPE_TYPE_ID_CINEMA_DAY_TIMESLOTS_VO,adapterName: "CinemaDayTimeslotsVOAdapter")
@JsonSerializable()
class CinemaDayTimeslotsVO {
  @JsonKey(name: "cinema_id")
  @HiveField(0)
  int? cinemaId;
  @JsonKey(name: "cinema")
  @HiveField(1)
  String? cinema;
  @JsonKey(name: "timeslots")
  @HiveField(2)
  List<TimeSlotVO>? timeslots;


  CinemaDayTimeslotsVO(this.cinemaId, this.cinema, this.timeslots);

  factory CinemaDayTimeslotsVO.fromJson(Map<String,dynamic> json) => _$CinemaDayTimeslotsVOFromJson(json);
  Map<String, dynamic> toJson() => _$CinemaDayTimeslotsVOToJson(this);
}