import 'package:json_annotation/json_annotation.dart';

part 'basic_response.g.dart';
@JsonSerializable()
class BasicResponse {
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;

  BasicResponse(this.code, this.message);

  factory BasicResponse.fromJson(Map<String,dynamic> json) => _$BasicResponseFromJson(json);

  Map<String,dynamic> toJson() => _$BasicResponseToJson(this);
}