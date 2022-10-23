// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facility_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FacilityVOAdapter extends TypeAdapter<FacilityVO> {
  @override
  final int typeId = 16;

  @override
  FacilityVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FacilityVO(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FacilityVO obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.img);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FacilityVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacilityVO _$FacilityVOFromJson(Map<String, dynamic> json) => FacilityVO(
      json['id'] as int?,
      json['title'] as String?,
      json['img'] as String?,
    );

Map<String, dynamic> _$FacilityVOToJson(FacilityVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'img': instance.img,
    };
