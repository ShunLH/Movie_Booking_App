import 'package:json_annotation/json_annotation.dart';
part 'production_countries_vo.g.dart';
@JsonSerializable()
class ProductionCountriesVO {

  @JsonKey(name: "iso_3166_1")
  String? iso31991;
  @JsonKey(name: "name")
  String? name;

  ProductionCountriesVO(this.iso31991, this.name);
  factory ProductionCountriesVO.fromJson(Map<String,dynamic> json) => _$ProductionCountriesVOFromJson(json);
  Map<String,dynamic> toJson() => _$ProductionCountriesVOToJson(this);
}