import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/cinema_day_timeslots_vo.dart';
import 'package:movie_booking_app/network/responses/basic_response.dart';
part 'get_cinema_and_st_by_date_response.g.dart';
@JsonSerializable()
class GetCinemaAndSTByDateResponse extends BasicResponse{
  @JsonKey(name: "data")
  List<CinemaDayTimeslotsVO>? data;


  GetCinemaAndSTByDateResponse(this.data,int? code,String? message) : super(code,message);

  factory GetCinemaAndSTByDateResponse.fromJson(Map<String,dynamic> json) => _$GetCinemaAndSTByDateResponseFromJson(json);

  Map<String,dynamic> toJson() => _$GetCinemaAndSTByDateResponseToJson(this);
}