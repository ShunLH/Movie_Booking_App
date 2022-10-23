import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';

part 'banner_vo.g.dart';

@HiveType(typeId: HYPE_TYPE_ID_BANNER_VO,adapterName: "BannerVOAdapter")
@JsonSerializable()
class BannerVO {
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "title")
  @HiveField(1)
  String? title;

  @JsonKey(name: "url")
  @HiveField(2)
  String? url;

  @JsonKey(name: "is_active")
  @HiveField(3)
  int? isActive;

  @HiveField(4)
  @JsonKey(name: "created_at")
  String? createdAt;

  @HiveField(5)
  @JsonKey(name: "updated_at")
  String? updatedAt;


  BannerVO(this.id, this.title, this.url, this.isActive, this.createdAt,
      this.updatedAt);

  factory BannerVO.fromJson(Map<String,dynamic> json) => _$BannerVOFromJson(json);
  Map<String, dynamic> toJson() => _$BannerVOToJson(this);

  @override
  String toString() {
    return 'BannerVO{id: $id, title: $title, url: $url, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}