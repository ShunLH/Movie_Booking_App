// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_type_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentTypeVOAdapter extends TypeAdapter<PaymentTypeVO> {
  @override
  final int typeId = 13;

  @override
  PaymentTypeVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentTypeVO(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String?,
      fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentTypeVO obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.icon)
      ..writeByte(3)
      ..write(obj.created_at)
      ..writeByte(4)
      ..write(obj.updated_at)
      ..writeByte(5)
      ..write(obj.deleted_at);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentTypeVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentTypeVO _$PaymentTypeVOFromJson(Map<String, dynamic> json) =>
    PaymentTypeVO(
      json['id'] as int?,
      json['title'] as String?,
      json['icon'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['deleted_at'] as String?,
    );

Map<String, dynamic> _$PaymentTypeVOToJson(PaymentTypeVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'icon': instance.icon,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'deleted_at': instance.deleted_at,
    };
