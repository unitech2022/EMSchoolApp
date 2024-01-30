// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_complete.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizComplete _$QuizCompleteFromJson(Map<String, dynamic> json) => QuizComplete(
      id: json['id'] as int,
      studantId: json['studantId'] as String,
      lessoinId: json['lessoinId'] as int,
      subjectId: json['subjectId'] as int,
      result: json['result'] as int,
      finalDegree: json['final'] as int,
      status: json['status'] as int,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$QuizCompleteToJson(QuizComplete instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studantId': instance.studantId,
      'lessoinId': instance.lessoinId,
      'subjectId': instance.subjectId,
      'result': instance.result,
      'final': instance.finalDegree,
      'status': instance.status,
      'createdAt': instance.createdAt,
    };
