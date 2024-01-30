
import 'package:em_school/features/common/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
//dart run build_runner build
part 'user_response.g.dart';
@JsonSerializable()
class UserResponse {
  final String token;
  final UserModel user;

  UserResponse({required this.token, required this.user});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);



  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
