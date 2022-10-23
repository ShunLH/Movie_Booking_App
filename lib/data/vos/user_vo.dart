import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';
import 'city_vo.dart';
part 'user_vo.g.dart';

@HiveType(typeId: HYPE_TYPE_ID_USER_VO,adapterName: "UserVOAdapter")
@JsonSerializable()
class UserVO {
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;
  @JsonKey(name: "name")
  @HiveField(1)
  String? name;
  @JsonKey(name: "email")
  @HiveField(2)
  String? email;
  @JsonKey(name: "phone")
  @HiveField(3)
  String? phone;
  @JsonKey(name: "total_expense")
  @HiveField(4)
  int? totalExpense;
  @JsonKey(name: "profile_image")
  @HiveField(5)
  String? profileImage;
  @HiveField(6)
  String? token;
  @HiveField(7)
  CityVO? selectedCity;


  UserVO(this.id, this.name, this.email, this.phone, this.totalExpense,
      this.profileImage);

  factory UserVO.fromJson(Map<String,dynamic> json) => _$UserVOFromJson(json);
  Map<String, dynamic> toJson() => _$UserVOToJson(this);

  @override
  String toString() {
    return 'UserVO{id: $id, name: $name, email: $email, phone: $phone, totalExpense: $totalExpense, profileImage: $profileImage, token: $token, selectedCity: $selectedCity}';
  }
}
