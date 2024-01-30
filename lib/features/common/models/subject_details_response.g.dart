// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectDetailsResponse _$SubjectDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    SubjectDetailsResponse(
      subject: SubjectModel.fromJson(json['subject'] as Map<String, dynamic>),
      courses: (json['courses'] as List<dynamic>)
          .map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      notes: (json['notes'] as List<dynamic>)
          .map((e) => NoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      lessons: (json['lessons'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => LessonModel.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
    );

Map<String, dynamic> _$SubjectDetailsResponseToJson(
        SubjectDetailsResponse instance) =>
    <String, dynamic>{
      'subject': instance.subject,
      'courses': instance.courses,
      'notes': instance.notes,
      'lessons': instance.lessons,
    };
