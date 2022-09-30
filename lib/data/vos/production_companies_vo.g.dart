// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'production_companies_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductionCompaniesVO _$ProductionCompaniesVOFromJson(
        Map<String, dynamic> json) =>
    ProductionCompaniesVO(
      json['id'] as int?,
      json['name'] as String?,
      json['logo_path'] as String?,
      json['origin_country'] as String?,
    );

Map<String, dynamic> _$ProductionCompaniesVOToJson(
        ProductionCompaniesVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo_path': instance.logoPath,
      'origin_country': instance.originCountry,
    };
