import 'package:json_annotation/json_annotation.dart';
part 'facility_vo.g.dart';
@JsonSerializable()
class FacilityVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name:"title")
  String? title;
  @JsonKey(name:"img")
  String? img;


  FacilityVO(this.id, this.title, this.img);

  factory FacilityVO.fromJson(Map<String,dynamic> json) => _$FacilityVOFromJson(json);
  Map<String,dynamic> toJson() => _$FacilityVOToJson(this);
}