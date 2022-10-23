// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_data_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConfigDataVOAdapter extends TypeAdapter<ConfigDataVO> {
  @override
  final int typeId = 20;

  @override
  ConfigDataVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConfigDataVO(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, ConfigDataVO obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.key)
      ..writeByte(2)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfigDataVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigDataVO _$ConfigDataVOFromJson(Map<String, dynamic> json) => ConfigDataVO(
      json['id'] as int?,
      json['key'] as String?,
      json['value'],
    );

Map<String, dynamic> _$ConfigDataVOToJson(ConfigDataVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'value': instance.value,
    };
