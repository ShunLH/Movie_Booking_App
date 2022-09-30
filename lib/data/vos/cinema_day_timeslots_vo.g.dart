// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_day_timeslots_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CinemaDayTimeslotsVO _$CinemaDayTimeslotsVOFromJson(
        Map<String, dynamic> json) =>
    CinemaDayTimeslotsVO(
      json['cinema_id'] as int?,
      json['cinema'] as String?,
      (json['timeslots'] as List<dynamic>?)
          ?.map((e) => TimeSlotVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CinemaDayTimeslotsVOToJson(
        CinemaDayTimeslotsVO instance) =>
    <String, dynamic>{
      'cinema_id': instance.cinemaId,
      'cinema': instance.cinema,
      'timeslots': instance.timeslots,
    };
