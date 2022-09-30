import 'package:json_annotation/json_annotation.dart';
part 'cinema_timeslot_status_vo.g.dart';
@JsonSerializable()
class CinemaTimeSlotStatusVO{
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "color")
  String? color;


  CinemaTimeSlotStatusVO(this.id, this.title, this.color);

  factory CinemaTimeSlotStatusVO.fromJson(Map<String,dynamic> json) => _$CinemaTimeSlotStatusVOFromJson(json);
  Map<String, dynamic> toJson() => _$CinemaTimeSlotStatusVOToJson(this);

  @override
  String toString() {
    return 'CinemaTimeSlotStatusVO{id: $id, title: $title, color: $color}';
  }
}