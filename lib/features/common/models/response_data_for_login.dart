

import 'package:em_school/features/common/models/stage_model.dart';
import 'package:em_school/features/common/models/subject_model.dart';
import 'package:em_school/features/common/models/type_education_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'class_room_model.dart';
//dart run build_runner build
part 'response_data_for_login.g.dart';
@JsonSerializable()
class ResponseDataForLogin {
final  List<TypeEducationModel> typeEducations;
 final List<StageModel> stages;
final List<ClassRoomModel> classRooms;
final List<SubjectModel> subjects;
  ResponseDataForLogin(
      {required this.typeEducations,
      required this.stages,
      required this.classRooms, required this.subjects});

  factory ResponseDataForLogin.fromJson(Map<String, dynamic> json) =>
      _$ResponseDataForLoginFromJson(json);
}