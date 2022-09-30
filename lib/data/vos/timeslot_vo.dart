import 'package:json_annotation/json_annotation.dart';
part 'timeslot_vo.g.dart';
@JsonSerializable()
class TimeSlotVO {
  @JsonKey(name: "cinema_day_timeslot_id")
  int? id;
  @JsonKey(name: "start_time")
  String? startTime;
  @JsonKey(name: "status")
  int? status;

  TimeSlotVO(this.id, this.startTime, this.status);

  factory TimeSlotVO.fromJson(Map<String,dynamic> json) => _$TimeSlotVOFromJson(json);
  Map<String, dynamic> toJson() => _$TimeSlotVOToJson(this);
}