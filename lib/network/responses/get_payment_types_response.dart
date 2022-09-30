import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/payment_type_vo.dart';
import 'package:movie_booking_app/network/responses/basic_response.dart';
part 'get_payment_types_response.g.dart';

@JsonSerializable()
class GetPaymentTypesResponse extends BasicResponse{
  @JsonKey(name: "data")
  List<PaymentTypeVO>? data;

  GetPaymentTypesResponse(this.data,int? code,String? message) : super(code,message);

  factory GetPaymentTypesResponse.fromJson(Map<String,dynamic> json) => _$GetPaymentTypesResponseFromJson(json);

  Map<String,dynamic> toJson() => _$GetPaymentTypesResponseToJson(this);
}