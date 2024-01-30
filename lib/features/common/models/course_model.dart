import 'package:json_annotation/json_annotation.dart';
//dart run build_runner build
part 'course_model.g.dart';
@JsonSerializable()
class CourseModel{


  final int id;
  final int subjectId;
  final String teacherId;
  final String nameAr;
  final String nameEng;
  final String image;
  final int status;
  final String createdAt;

  CourseModel({required this.id, required this.subjectId, required this.teacherId,
    required this.nameAr, required this.nameEng,
    required this.image, required this.status,
    required this.createdAt});



  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);



  Map<String, dynamic> toJson() => _$CourseModelToJson(this);
}