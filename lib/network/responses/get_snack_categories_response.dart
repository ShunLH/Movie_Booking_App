import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/snack_category_vo.dart';
import 'package:movie_booking_app/network/responses/basic_response.dart';
part 'get_snack_categories_response.g.dart';
@JsonSerializable()
class GetSnackCategoriesResponse extends BasicResponse{
  @JsonKey(name: "data")
  List<SnackCategoryVO>? data;

  GetSnackCategoriesResponse(this.data,int? code,String? message) : super(code,message);

  factory GetSnackCategoriesResponse.fromJson(Map<String,dynamic> json) => _$GetSnackCategoriesResponseFromJson(json);

  Map<String,dynamic> toJson() => _$GetSnackCategoriesResponseToJson(this);
}