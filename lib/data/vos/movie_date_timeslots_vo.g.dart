// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_date_timeslots_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieDateTimeSlotsVOAdapter extends TypeAdapter<MovieDateTimeSlotsVO> {
  @override
  final int typeId = 22;

  @override
  MovieDateTimeSlotsVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieDateTimeSlotsVO(
      fields[0] as String?,
      (fields[1] as List?)?.cast<CinemaDayTimeslotsVO>(),
    );
  }

  @override
  void write(BinaryWriter writer, MovieDateTimeSlotsVO obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.cinemaDayTimeSlotsList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieDateTimeSlotsVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
