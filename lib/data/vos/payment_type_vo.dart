import 'package:json_annotation/json_annotation.dart';
part 'payment_type_vo.g.dart';
@JsonSerializable()
class PaymentTypeVO {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "icon")
  String? icon;
  @JsonKey(name: "created_at")
  String? created_at;
  @JsonKey(name: "updated_at")
  String? updated_at;
  @JsonKey(name: "deleted_at")
  String? deleted_at;


  PaymentTypeVO(this.id, this.title, this.icon, this.created_at,
      this.updated_at, this.deleted_at);

  factory PaymentTypeVO.fromJson(Map<String,dynamic> json) => _$PaymentTypeVOFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentTypeVOToJson(this);
}