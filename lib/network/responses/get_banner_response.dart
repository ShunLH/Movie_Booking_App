import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/banner_vo.dart';
import 'package:movie_booking_app/network/responses/basic_response.dart';
part 'get_banner_response.g.dart';
@JsonSerializable()
class GetBannerResponse extends BasicResponse {
  @JsonKey(name: "data")
  List<BannerVO>? data;

  GetBannerResponse(this.data,int? code,String? message) : super(code,message);

  factory GetBannerResponse.fromJson(Map<String,dynamic> json) => _$GetBannerResponseFromJson(json);

  Map<String,dynamic> toJson() => _$GetBannerResponseToJson(this);
}