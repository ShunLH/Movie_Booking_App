// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cinema_and_st_by_date_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCinemaAndSTByDateResponse _$GetCinemaAndSTByDateResponseFromJson(
        Map<String, dynamic> json) =>
    GetCinemaAndSTByDateResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => CinemaDayTimeslotsVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['code'] as int?,
      json['message'] as String?,
    );

Map<String, dynamic> _$GetCinemaAndSTByDateResponseToJson(
        GetCinemaAndSTByDateResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
