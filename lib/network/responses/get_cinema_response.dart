import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/network/responses/basic_response.dart';

part 'get_cinema_response.g.dart';
@JsonSerializable()
class GetCinemaResponse extends BasicResponse{
  @JsonKey(name: "data")
  List<CinemaVO>? data;
  @JsonKey(name: "latest_time")
  String? latestTime;

  GetCinemaResponse(this.data,this.latestTime,int? code,String? message) : super(code,message);

  factory GetCinemaResponse.fromJson(Map<String,dynamic> json) => _$GetCinemaResponseFromJson(json);

  Map<String,dynamic> toJson() => _$GetCinemaResponseToJson(this);
}