// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_day_timeslots_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CinemaDayTimeslotsVOAdapter extends TypeAdapter<CinemaDayTimeslotsVO> {
  @override
  final int typeId = 18;

  @override
  CinemaDayTimeslotsVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CinemaDayTimeslotsVO(
      fields[0] as int?,
      fields[1] as String?,
      (fields[2] as List?)?.cast<TimeSlotVO>(),
    );
  }

  @override
  void write(BinaryWriter writer, CinemaDayTimeslotsVO obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.cinemaId)
      ..writeByte(1)
      ..write(obj.cinema)
      ..writeByte(2)
      ..write(obj.timeslots);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CinemaDayTimeslotsVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
