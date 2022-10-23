// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CinemaVOAdapter extends TypeAdapter<CinemaVO> {
  @override
  final int typeId = 2;

  @override
  CinemaVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CinemaVO(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String?,
      fields[5] as String?,
      (fields[6] as List?)?.cast<FacilityVO>(),
      (fields[7] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, CinemaVO obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.promoVdoURL)
      ..writeByte(6)
      ..write(obj.facilities)
      ..writeByte(7)
      ..write(obj.safety);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CinemaVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CinemaVO _$CinemaVOFromJson(Map<String, dynamic> json) => CinemaVO(
      json['id'] as int?,
      json['name'] as String?,
      json['phone'] as String?,
      json['email'] as String?,
      json['address'] as String?,
      json['promo_vdo_url'] as String?,
      (json['facilities'] as List<dynamic>?)
          ?.map((e) => FacilityVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['safety'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CinemaVOToJson(CinemaVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'address': instance.address,
      'promo_vdo_url': instance.promoVdoURL,
      'facilities': instance.facilities,
      'safety': instance.safety,
    };
