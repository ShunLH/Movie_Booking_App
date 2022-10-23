import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';
part 'credit_vo.g.dart';

@HiveType(typeId: HYPE_TYPE_ID_CREDIT_VO,adapterName: "CreditVOAdapter")
@JsonSerializable()
class CreditVO {
  @JsonKey(name: "adult")
  @HiveField(0)
  bool? adult;
  @JsonKey(name: "gender")
  @HiveField(1)
  int? gender;
  @JsonKey(name: "id")
  @HiveField(2)
  int? id;
  @JsonKey(name: "known_for_department")
  @HiveField(3)
  String? knownForDepartment;
  @JsonKey(name: "name")
  @HiveField(4)
  String? name;
  @JsonKey(name: "original_name")
  @HiveField(5)
  String? originalName;
  @JsonKey(name: "popularity")
  @HiveField(6)
  double? popularity;
  @JsonKey(name: "profile_path")
  @HiveField(7)
  String? profilePath;
  @JsonKey(name: "cast_id")
  @HiveField(8)
  int? castId;
  @JsonKey(name: "character")
  @HiveField(9)
  String? character;
  @JsonKey(name: "credit_id")
  @HiveField(10)
  String? creditId;
  @JsonKey(name: "order")
  @HiveField(11)
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
