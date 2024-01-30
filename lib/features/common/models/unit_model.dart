import 'package:json_annotation/json_annotation.dart';
import 'lesson_model.dart';
part 'unit_model.g.dart';

@JsonSerializable()
class UnitModel {
  final int id;
  final int courseId;

  final String nameAr;
  final String nameEng;
  final String imageUrl;
  final int status;
  final String createdAt;

  UnitModel({required this.id, required this.courseId, required this.nameAr, required this.nameEng, required this.imageUrl, required this.status, required this.createdAt});
  factory UnitModel.fromJson(Map<String, dynamic> json) =>
      _$UnitModelFromJson(json);



  Map<String, dynamic> toJson() => _$UnitModelToJson(this);
}

@JsonSerializable()
class UnitResponse{
  final UnitModel unitModel;
  final List<LessonModel> lessons;

  UnitResponse({required this.unitModel, required this.lessons});

  factory UnitResponse.fromJson(Map<String, dynamic> json) =>
      _$UnitResponseFromJson(json);
}

