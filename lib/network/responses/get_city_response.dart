import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/city_vo.dart';
import 'package:movie_booking_app/network/responses/basic_response.dart';
part 'get_city_response.g.dart';
@JsonSerializable()
class GetCityResponse extends BasicResponse {
  @JsonKey(name: "data")
  List<CityVO>? data;

  GetCityResponse(this.data,int? code,String? message) : super(code,message);

  factory GetCityResponse.fromJson(Map<String,dynamic> json) => _$GetCityResponseFromJson(json);

  Map<String,dynamic> toJson() => _$GetCityResponseToJson(this);
}