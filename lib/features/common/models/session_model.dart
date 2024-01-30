
//dart run build_runner build
import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_model.g.dart';
@JsonSerializable()
class SessionModel {
  final int id;
  final int scheduleId;
  final String nameAr;
  final String nameEng;
  final int status;
  final String createdAt;

  SessionModel(
      {required this.id,
      required this.scheduleId,
      required this.nameAr,
      required this.nameEng,
      required this.status,
      required this.createdAt});

  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);

}
