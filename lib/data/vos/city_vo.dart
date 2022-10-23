import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';
part 'city_vo.g.dart';

@HiveType(typeId: HYPE_TYPE_ID_CITY_VO,adapterName: "CityVOAdapter")
@JsonSerializable()
class CityVO {
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;
  @JsonKey(name: "name")
  @HiveField(1)
  String? name;

  @JsonKey(name: "created_at")
  @HiveField(2)
  String? createdAt;

  @JsonKey(name: "updated_at")
  @HiveField(3)
  String? updatedAt;

  @HiveField(4)
  bool? isSelected;

  CityVO(this.id, this.name, this.createdAt, this.updatedAt,this.isSelected);


  factory CityVO.fromJson(Map<String,dynamic> json) => _$CityVOFromJson(json);
  Map<String, dynamic> toJson() => _$CityVOToJson(this);

  @override
  String toString() {
    return 'CityVO{id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}