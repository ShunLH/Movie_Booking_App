// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityVO _$CityVOFromJson(Map<String, dynamic> json) => CityVO(
      json['id'] as int?,
      json['name'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
    );

Map<String, dynamic> _$CityVOToJson(CityVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
