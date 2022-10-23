import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/facility_vo.dart';

import '../../persistence/hive_constants.dart';
part 'cinema_vo.g.dart';

@HiveType(typeId: HYPE_TYPE_ID_CINEMA_VO,adapterName: "CinemaVOAdapter")
@JsonSerializable()
class CinemaVO {
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;
  @JsonKey(name: "name")
  @HiveField(1)
  String? name;
  @JsonKey(name: "phone")
  @HiveField(2)
  String? phone;
  @JsonKey(name: "email")
  @HiveField(3)
  String? email;
  @JsonKey(name: "address")
  @HiveField(4)
  String? address;
  @JsonKey(name: "promo_vdo_url")
  @HiveField(5)
  String? promoVdoURL;
  @JsonKey(name: "facilities")
  @HiveField(6)
  List<FacilityVO>? facilities;
  @JsonKey(name: "safety")
  @HiveField(7)
  List<String>? safety;


  CinemaVO(this.id, this.name, this.phone, this.email, this.address,
      this.promoVdoURL, this.facilities, this.safety);

  factory CinemaVO.fromJson(Map<String,dynamic> json) => _$CinemaVOFromJson(json);
  Map<String, dynamic> toJson() => _$CinemaVOToJson(this);
}