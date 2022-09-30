import 'package:json_annotation/json_annotation.dart';
part 'credit_vo.g.dart';

@JsonSerializable()
class CreditVO {
  @JsonKey(name: "adult")
  bool? adult;
  @JsonKey(name: "gender")
  int? gender;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "known_for_department")
  String? knownForDepartment;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "original_name")
  String? originalName;
  @JsonKey(name: "popularity")
  double? popularity;
  @JsonKey(name: "profile_path")
  String? profilePath;
  @JsonKey(name: "cast_id")
  int? castId;
  @JsonKey(name: "character")
  String? character;
  @JsonKey(name: "credit_id")
  String? creditId;
  @JsonKey(name: "order")
  int? order;

  CreditVO(
      this.adult,
      this.gender,
      this.id,
      this.knownForDepartment,
      this.name,
      this.originalName,
      this.popularity,
      this.castId,
      this.character,
      this.creditId,
      this.order,
      this.profilePath,

      );

  factory CreditVO.fromJson(Map<String, dynamic> json) =>
      _$CreditVOFromJson(json);

  Map<String, dynamic> toJson() => _$CreditVOToJson(this);

  bool isActor() {
    return knownForDepartment == KNOWN_FOR_DEPARTMENT_ACTING;
  }

  bool isCreator() {
    return knownForDepartment != KNOWN_FOR_DEPARTMENT_ACTING;
  }

  @override
  String toString() {
    return 'CreditVO{adult: $adult, gender: $gender, id: $id, knownForDepartment: $knownForDepartment, originalName: $originalName, popularity: $popularity, castId: $castId, character: $character, creditId: $creditId, order: $order}';
  }
}

const String KNOWN_FOR_DEPARTMENT_ACTING = "Acting";
