// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => CourseModel(
      id: json['id'] as int,
      subjectId: json['subjectId'] as int,
      teacherId: json['teacherId'] as String,
      nameAr: json['nameAr'] as String,
      nameEng: json['nameEng'] as String,
      image: json['image'] as String,
      status: json['status'] as int,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subjectId': instance.subjectId,
      'teacherId': instance.teacherId,
      'nameAr': instance.nameAr,
      'nameEng': instance.nameEng,
      'image': instance.image,
      'status': instance.status,
      'createdAt': instance.createdAt,
    };
