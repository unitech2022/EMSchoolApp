import 'package:em_school/features/common/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

//dart run build_runner build
part 'reply_model.g.dart';

@JsonSerializable()
class ReplayModel {


  final int id;
  final int commentId;
  final String userId;
  final String text;
  final int status;
  final String createAte;

  ReplayModel(
      {required this.id,
      required this.commentId,
      required this.userId,
      required this.text,
      required this.status,
      required this.createAte});


  factory ReplayModel.fromJson(Map<String, dynamic> json) =>
      _$ReplayModelFromJson(json);
}

@JsonSerializable()
class ReplayResponse{
  final UserModel userDetail;
  final ReplayModel reply;

  ReplayResponse({required this.userDetail, required this.reply});
  factory ReplayResponse.fromJson(Map<String, dynamic> json) =>
      _$ReplayResponseFromJson(json);
}
