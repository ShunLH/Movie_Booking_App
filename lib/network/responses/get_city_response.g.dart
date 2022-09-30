// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_city_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCityResponse _$GetCityResponseFromJson(Map<String, dynamic> json) =>
    GetCityResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => CityVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['code'] as int?,
      json['message'] as String?,
    );

Map<String, dynamic> _$GetCityResponseToJson(GetCityResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
