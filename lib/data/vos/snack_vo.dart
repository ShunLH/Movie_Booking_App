import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';
part 'snack_vo.g.dart';

@HiveType(typeId: HYPE_TYPE_ID_SNACK_VO,adapterName: "SnackVOAdapter")
@JsonSerializable()
class SnackVO{
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;
  @JsonKey(name: "name")
  @HiveField(1)
  String? name;
  @JsonKey(name: "description")
  @HiveField(2)
  String? description;
  @JsonKey(name: "price")
  @HiveField(3)
  int? price;
  @JsonKey(name: "category_id")
  @HiveField(4)
  int? categoryId;
  @JsonKey(name: "image")
  @HiveField(5)
  String? image;
  int? quantity = 0;


  SnackVO(this.id, this.name, this.description, this.price, this.categoryId,
      this.image);

  factory SnackVO.fromJson(Map<String,dynamic> json) => _$SnackVOFromJson(json);
  Map<String, dynamic> toJson() => _$SnackVOToJson(this);

  @override
  String toString() {
    return 'SnackVO{id: $id, name: $name, description: $description, price: $price, categoryId: $categoryId, image: $image}';
  }
}