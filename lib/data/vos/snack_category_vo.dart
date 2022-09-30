import 'package:json_annotation/json_annotation.dart';
part 'snack_category_vo.g.dart';
@JsonSerializable()
class SnackCategoryVO{
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "title_mm")
  String? title_mm;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "created_at")
  String? created_at;
  @JsonKey(name: "updated_at")
  String? updated_at;
  @JsonKey(name: "deleted_at")
  String? deleted_at;


  SnackCategoryVO(this.id, this.title, this.title_mm, this.isActive,
      this.created_at, this.updated_at, this.deleted_at);

  factory SnackCategoryVO.fromJson(Map<String,dynamic> json) => _$SnackCategoryVOFromJson(json);
  Map<String, dynamic> toJson() => _$SnackCategoryVOToJson(this);

}