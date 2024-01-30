
import 'package:json_annotation/json_annotation.dart';
//dart run build_runner build
part 'subject_model.g.dart';
@JsonSerializable()
class SubjectModel {


  final int id;
  final int typeEducationId;
  final int stageId;
  final int classRoomId;
  final String nameAr;
  final String nameEng;
  final String image;
  final int status;
  final double progress;
  final String createdAt;

  SubjectModel({required this.id,required this.progress, required this.typeEducationId, required this.stageId, required this.classRoomId, required this.nameAr, required this.nameEng, required this.image, required this.status, required this.createdAt});

  factory SubjectModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectModelFromJson(json);



  Map<String, dynamic> toJson() => _$SubjectModelToJson(this);
}
