// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_teacher_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeTeacherResponse _$HomeTeacherResponseFromJson(Map<String, dynamic> json) =>
    HomeTeacherResponse(
      SubjectModel.fromJson(json['subject'] as Map<String, dynamic>),
      (json['courses'] as List<dynamic>)
          .map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['unitResponses'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => UnitResponse.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
      teacher: UserModel.fromJson(json['teacher'] as Map<String, dynamic>),
      lessons: (json['lessons'] as List<dynamic>)
          .map((e) => LessonTeacherResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      students: (json['students'] as List<dynamic>)
          .map((e) => StudentResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      alerts: (json['alerts'] as List<dynamic>)
          .map((e) => AlertModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeTeacherResponseToJson(
        HomeTeacherResponse instance) =>
    <String, dynamic>{
      'teacher': instance.teacher,
      'lessons': instance.lessons,
      'students': instance.students,
      'alerts': instance.alerts,
      'subject': instance.subject,
      'courses': instance.courses,
      'unitResponses': instance.unitResponses,
    };

StudentResponse _$StudentResponseFromJson(Map<String, dynamic> json) =>
    StudentResponse(
      student: UserModel.fromJson(json['student'] as Map<String, dynamic>),
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => QuizComplete.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StudentResponseToJson(StudentResponse instance) =>
    <String, dynamic>{
      'student': instance.student,
      'exercises': instance.exercises,
    };

LessonTeacherResponse _$LessonTeacherResponseFromJson(
        Map<String, dynamic> json) =>
    LessonTeacherResponse(
      lesson: LessonModel.fromJson(json['lesson'] as Map<String, dynamic>),
      successfuly: json['successfuly'] as int,
      comments: (json['comments'] as List<dynamic>)
          .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LessonTeacherResponseToJson(
        LessonTeacherResponse instance) =>
    <String, dynamic>{
      'lesson': instance.lesson,
      'successfuly': instance.successfuly,
      'comments': instance.comments,
    };
