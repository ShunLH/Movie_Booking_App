import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';
part 'cinema_timeslot_status_vo.g.dart';

@HiveType(typeId: HYPE_TYPE_ID_CINEMA_TIMESLOT_STATUS_VO,adapterName: "CinemaTimeSlotStatusVOAdapter")
@JsonSerializable()
class CinemaTimeSlotStatusVO{
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;
  @JsonKey(name: "title")
  @HiveField(1)
  String? title;
  @JsonKey(name: "color")
  @HiveField(2)
  String? color;


  CinemaTimeSlotStatusVO(this.id, this.title, this.color);

  factory CinemaTimeSlotStatusVO.fromJson(Map<String,dynamic> json) => _$CinemaTimeSlotStatusVOFromJson(json);
  Map<String, dynamic> toJson() => _$CinemaTimeSlotStatusVOToJson(this);

  @override
  String toString() {
    return 'CinemaTimeSlotStatusVO{id: $id, title: $title, color: $color}';
  }
}