import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/cinema_timeslot_status_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';
part 'config_data_vo.g.dart';

@HiveType(typeId: HYPE_TYPE_ID_CONFIG_DATA_VO,adapterName: "ConfigDataVOAdapter")
@JsonSerializable()
class
ConfigDataVO{
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;
  @JsonKey(name: "key")
  @HiveField(1)
  String? key;
  @JsonKey(name: "value")
  @HiveField(2)
  var value;

  ConfigDataVO(this.id, this.key, this.value);

  factory ConfigDataVO.fromJson(Map<String,dynamic> json) => _$ConfigDataVOFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigDataVOToJson(this);

  @override
  String toString() {
    return 'ConfigDataVO{id: $id, key: $key, value: $value}';
  }
}