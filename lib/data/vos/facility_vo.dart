import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';
part 'facility_vo.g.dart';

@HiveType(typeId: HYPE_TYPE_ID_FACILITY_VO,adapterName: "FacilityVOAdapter")
@JsonSerializable()
class FacilityVO {
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name:"title")
  @HiveField(1)
  String? title;

  @JsonKey(name:"img")
  @HiveField(2)
  String? img;


  FacilityVO(this.id, this.title, this.img);

  factory FacilityVO.fromJson(Map<String,dynamic> json) => _$FacilityVOFromJson(json);
  Map<String,dynamic> toJson() => _$FacilityVOToJson(this);
}