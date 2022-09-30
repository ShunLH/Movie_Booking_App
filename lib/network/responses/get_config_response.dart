import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/config_data_vo.dart';
import 'package:movie_booking_app/network/responses/basic_response.dart';

part 'get_config_response.g.dart';

@JsonSerializable()
class GetConfigResponse extends BasicResponse {
  @JsonKey(name: "data")
  List<ConfigDataVO>? data;

  GetConfigResponse(this.data,int? code,String? message) : super(code,message);

  factory GetConfigResponse.fromJson(Map<String,dynamic> json) => _$GetConfigResponseFromJson(json);

  Map<String,dynamic> toJson() => _$GetConfigResponseToJson(this);
}