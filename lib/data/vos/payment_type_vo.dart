import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';
part 'payment_type_vo.g.dart';

@HiveType(typeId: HYPE_TYPE_ID_PAYMENT_TYPE_VO,adapterName: "PaymentTypeVOAdapter")
@JsonSerializable()
class PaymentTypeVO {

  @JsonKey(name: "id")
  @HiveField(0)
  int? id;
  @JsonKey(name: "title")
  @HiveField(1)
  String? title;
  @JsonKey(name: "icon")
  @HiveField(2)
  String? icon;
  @JsonKey(name: "created_at")
  @HiveField(3)
  String? created_at;
  @JsonKey(name: "updated_at")
  @HiveField(4)
  String? updated_at;
  @JsonKey(name: "deleted_at")
  @HiveField(5)
  String? deleted_at;


  PaymentTypeVO(this.id, this.title, this.icon, this.created_at,
      this.updated_at, this.deleted_at);

  factory PaymentTypeVO.fromJson(Map<String,dynamic> json) => _$PaymentTypeVOFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentTypeVOToJson(this);
}