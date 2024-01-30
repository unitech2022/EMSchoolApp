import 'package:em_school/features/common/models/session_model.dart';
import 'package:json_annotation/json_annotation.dart';
//dart run build_runner build
part 'schedule_model.g.dart';
@JsonSerializable()
class ScheduleModel {
  final int id;
  final int typeEducationId;
  final int stageId;
  final int classRoomId;
  final String nameAr;
  final String nameEng;

  final int status;
  final String createdAt;

  ScheduleModel(
      {required this.id,
      required this.typeEducationId,
      required this.stageId,
      required this.classRoomId,
      required this.nameAr,
      required this.nameEng,

      required this.status,
      required this.createdAt});

  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);
}

@JsonSerializable()
class ScheduleResponse{
  final ScheduleModel schedule;
  final List<SessionModel> sessions;

  ScheduleResponse({required this.schedule, required this.sessions});
  factory ScheduleResponse.fromJson(Map<String, dynamic> json) =>
      _$ScheduleResponseFromJson(json);
}
