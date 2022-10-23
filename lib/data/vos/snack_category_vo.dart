import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';
part 'snack_category_vo.g.dart';

@HiveType(typeId: HYPE_TYPE_ID_SNACK_CATEGORY_VO,adapterName: "SnackCategoryVOAdapter")
@JsonSerializable()
class SnackCategoryVO{
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;
  @JsonKey(name: "title")
  @HiveField(1)
  String? title;
  @JsonKey(name: "title_mm")
  @HiveField(2)
  String? title_mm;
  @JsonKey(name: "is_active")
  @HiveField(3)
  int? isActive;
  @JsonKey(name: "created_at")
  @HiveField(4)
  String? created_at;
  @JsonKey(name: "updated_at")
  @HiveField(5)
  String? updated_at;
  @JsonKey(name: "deleted_at")
  @HiveField(6)
  String? deleted_at;


  SnackCategoryVO(this.id, this.title, this.title_mm, this.isActive,
      this.created_at, this.updated_at, this.deleted_at);

  factory SnackCategoryVO.fromJson(Map<String,dynamic> json) => _$SnackCategoryVOFromJson(json);
  Map<String, dynamic> toJson() => _$SnackCategoryVOToJson(this);

}