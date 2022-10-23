// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_timeslot_status_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CinemaTimeSlotStatusVOAdapter
    extends TypeAdapter<CinemaTimeSlotStatusVO> {
  @override
  final int typeId = 19;

  @override
  CinemaTimeSlotStatusVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CinemaTimeSlotStatusVO(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CinemaTimeSlotStatusVO obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CinemaTimeSlotStatusVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CinemaTimeSlotStatusVO _$CinemaTimeSlotStatusVOFromJson(
        Map<String, dynamic> json) =>
    CinemaTimeSlotStatusVO(
      json['id'] as int?,
      json['title'] as String?,
      json['color'] as String?,
    );

Map<String, dynamic> _$CinemaTimeSlotStatusVOToJson(
        CinemaTimeSlotStatusVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'color': instance.color,
    };
