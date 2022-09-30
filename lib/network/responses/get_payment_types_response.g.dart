// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_payment_types_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPaymentTypesResponse _$GetPaymentTypesResponseFromJson(
        Map<String, dynamic> json) =>
    GetPaymentTypesResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => PaymentTypeVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['code'] as int?,
      json['message'] as String?,
    );

Map<String, dynamic> _$GetPaymentTypesResponseToJson(
        GetPaymentTypesResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
