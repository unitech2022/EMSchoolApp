import 'package:em_school/features/common/models/course_model.dart';
import 'package:em_school/features/common/models/lesson_model.dart';
import 'package:em_school/features/common/models/note_model.dart';
import 'package:em_school/features/common/models/subject_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'subject_details_response.g.dart';
@JsonSerializable()
class SubjectDetailsResponse{
  final SubjectModel subject;
  final List<CourseModel> courses;
  final List<NoteModel> notes;
  final List<List<LessonModel>> lessons;

  SubjectDetailsResponse({required this.subject, required this.courses, required this.notes,  required this.lessons});


  factory SubjectDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$SubjectDetailsResponseFromJson(json);



  Map<String, dynamic> toJson() => _$SubjectDetailsResponseToJson(this);
}