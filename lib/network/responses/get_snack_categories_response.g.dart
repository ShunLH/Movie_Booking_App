// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_snack_categories_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSnackCategoriesResponse _$GetSnackCategoriesResponseFromJson(
        Map<String, dynamic> json) =>
    GetSnackCategoriesResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => SnackCategoryVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['code'] as int?,
      json['message'] as String?,
    );

Map<String, dynamic> _$GetSnackCategoriesResponseToJson(
        GetSnackCategoriesResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
