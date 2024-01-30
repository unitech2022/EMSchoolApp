import 'package:json_annotation/json_annotation.dart';
//dart run build_runner build
part 'user_model.g.dart';
@JsonSerializable()
class UserModel {
  final String id;
  final String userName;
  final String role;
  final String fullName;
  final String uniqCode;
  final String? deviceToken;
  final String? profileImage;
  final int status;
  final String code;
  final int? studantId;
  final int typeEducationId;
  final int stageId;
  final int subjectId;
  final int classRoomId;

  UserModel(
      {required this.id,
      required this.userName,
      required this.role, required this.subjectId,
      required this.fullName,
      required this.uniqCode,
      required this.deviceToken,
        required this.profileImage,
      required this.status,
      required this.code,
      required this.studantId,
      required this.typeEducationId,
      required this.stageId,
      required this.classRoomId});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);



  Map<String, dynamic> toJson() => _$UserModelToJson(this);

}
