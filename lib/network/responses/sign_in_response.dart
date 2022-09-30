import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/user_vo.dart';
part 'sign_in_response.g.dart';

@JsonSerializable()
class SignInResponse {
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  UserVO? data;
  @JsonKey(name: "token")
  String? token;


  SignInResponse(this.code,this.message,this.data, this.token);

  factory SignInResponse.fromJson(Map<String,dynamic> json) => _$SignInResponseFromJson(json);

  Map<String,dynamic> toJson() => _$SignInResponseToJson(this);
}
