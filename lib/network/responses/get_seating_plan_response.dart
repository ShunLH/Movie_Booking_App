import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/seat_vo.dart';
import 'package:movie_booking_app/network/responses/basic_response.dart';
part 'get_seating_plan_response.g.dart';
@JsonSerializable()
class GetSeatingPlanResponse extends BasicResponse{
  @JsonKey(name: "data")
  List<SeatVO>? data;

  GetSeatingPlanResponse(this.data,int? code,String? message) : super(code,message);

  factory GetSeatingPlanResponse.fromJson(Map<String,dynamic> json) => _$GetSeatingPlanResponseFromJson(json);

  Map<String,dynamic> toJson() => _$GetSeatingPlanResponseToJson(this);
}