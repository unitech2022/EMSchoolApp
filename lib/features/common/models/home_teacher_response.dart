import 'package:em_school/features/common/models/alert_model.dart';
import 'package:em_school/features/common/models/comment_model.dart';
import 'package:em_school/features/common/models/course_model.dart';
import 'package:em_school/features/common/models/lesson_model.dart';
import 'package:em_school/features/common/models/quiz_complete.dart';
import 'package:em_school/features/common/models/subject_model.dart';
import 'package:em_school/features/common/models/unit_model.dart';
import 'package:em_school/features/common/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_teacher_response.g.dart';
@JsonSerializable()
class HomeTeacherResponse {
  final UserModel teacher;
final List<LessonTeacherResponse> lessons;
  final List<StudentResponse> students;
  final List<AlertModel> alerts;
   final SubjectModel subject;
  final List<CourseModel> courses;
  final List<List<UnitResponse>> unitResponses;


  HomeTeacherResponse(this.subject, this.courses, this.unitResponses,  {required this.teacher, required this.lessons, required this.students, required this.alerts});
  factory HomeTeacherResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeTeacherResponseFromJson(json);
}

@JsonSerializable()
class StudentResponse {
  final UserModel student;
  final List<QuizComplete> exercises;

  StudentResponse({required this.student, required this.exercises});
  factory StudentResponse.fromJson(Map<String, dynamic> json) =>
      _$StudentResponseFromJson(json);

}

@JsonSerializable()
class LessonTeacherResponse {
  final LessonModel lesson;
  final int successfuly;
  final List<CommentModel> comments;

  LessonTeacherResponse({required this.lesson, required this.successfuly, required this.comments});

  factory LessonTeacherResponse.fromJson(Map<String, dynamic> json) =>
      _$LessonTeacherResponseFromJson(json);


}