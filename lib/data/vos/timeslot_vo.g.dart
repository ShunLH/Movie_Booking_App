// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeslot_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSlotVO _$TimeSlotVOFromJson(Map<String, dynamic> json) => TimeSlotVO(
      json['cinema_day_timeslot_id'] as int?,
      json['start_time'] as String?,
      json['status'] as int?,
    );

Map<String, dynamic> _$TimeSlotVOToJson(TimeSlotVO instance) =>
    <String, dynamic>{
      'cinema_day_timeslot_id': instance.id,
      'start_time': instance.startTime,
      'status': instance.status,
    };
