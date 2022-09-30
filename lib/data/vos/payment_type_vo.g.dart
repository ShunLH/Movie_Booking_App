// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_type_vo.dart';

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
