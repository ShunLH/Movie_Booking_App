import 'package:json_annotation/json_annotation.dart';

import '../../data/vos/ticket_vo.dart';
import 'basic_response.dart';
part 'get_checkout_response.g.dart';

@JsonSerializable()
class GetCheckOutResponse extends BasicResponse {
  @JsonKey(name: "data")
  TicketVO? data;

  GetCheckOutResponse(this.data,int? code,String? message) : super(code,message);

  factory GetCheckOutResponse.fromJson(Map<String,dynamic> json) => _$GetCheckOutResponseFromJson(json);

  Map<String,dynamic> toJson() => _$GetCheckOutResponseToJson(this);
}