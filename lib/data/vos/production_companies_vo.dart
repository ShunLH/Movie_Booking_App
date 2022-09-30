import 'package:json_annotation/json_annotation.dart';
part 'production_companies_vo.g.dart';
@JsonSerializable()
class ProductionCompaniesVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "logo_path")
  String? logoPath;

  @JsonKey(name: "origin_country")
  String? originCountry;


  ProductionCompaniesVO(this.id, this.name, this.logoPath, this.originCountry);

  factory ProductionCompaniesVO.fromJson(Map<String,dynamic> json) => _$ProductionCompaniesVOFromJson(json);
  Map<String,dynamic> toJson() => _$ProductionCompaniesVOToJson(this);
}