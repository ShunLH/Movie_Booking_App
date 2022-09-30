// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snack_category_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SnackCategoryVO _$SnackCategoryVOFromJson(Map<String, dynamic> json) =>
    SnackCategoryVO(
      json['id'] as int?,
      json['title'] as String?,
      json['title_mm'] as String?,
      json['is_active'] as int?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['deleted_at'] as String?,
    );

Map<String, dynamic> _$SnackCategoryVOToJson(SnackCategoryVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'title_mm': instance.title_mm,
      'is_active': instance.isActive,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'deleted_at': instance.deleted_at,
    };
