import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';
part 'timeslot_vo.g.dart';

@HiveType(typeId: HYPE_TYPE_ID_TIMESLOT_VO,adapterName: "TimeSlotVOAdapter")
@JsonSerializable()
class TimeSlotVO {
  @JsonKey(name: "cinema_day_timeslot_id")
  @HiveField(0)
  int? id;
  @JsonKey(name: "start_time")
  @HiveField(1)
  String? startTime;
  @JsonKey(name: "status")
  @HiveField(2)
  int? status;

  TimeSlotVO(this.id, this.startTime, this.status);

  factory TimeSlotVO.fromJson(Map<String,dynamic> json) => _$TimeSlotVOFromJson(json);
  Map<String, dynamic> toJson() => _$TimeSlotVOToJson(this);
}

