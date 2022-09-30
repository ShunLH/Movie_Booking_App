
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/snack_vo.dart';
import 'package:movie_booking_app/network/responses/basic_response.dart';
part 'get_snacks_response.g.dart';
@JsonSerializable()
class GetSnacksResponse extends BasicResponse{
  @JsonKey(name: "data")
  List<SnackVO>? data;

  GetSnacksResponse(this.data,int? code,String? message) : super(code,message);

  factory GetSnacksResponse.fromJson(Map<String,dynamic> json) => _$GetSnacksResponseFromJson(json);

  Map<String,dynamic> toJson() => _$GetSnacksResponseToJson(this);
}