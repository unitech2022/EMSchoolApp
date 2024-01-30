// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizModel _$QuizModelFromJson(Map<String, dynamic> json) => QuizModel(
      id: json['id'] as int,
      lessonId: json['lessonId'] as int,
      descAr: json['descAr'] as String,
      descEng: json['descEng'] as String,
      file: json['file'] as String?,
      type: json['type'] as int,
    );

Map<String, dynamic> _$QuizModelToJson(QuizModel instance) => <String, dynamic>{
      'id': instance.id,
      'lessonId': instance.lessonId,
      'descAr': instance.descAr,
      'descEng': instance.descEng,
      'file': instance.file,
      'type': instance.type,
    };

QuizResponse _$QuizResponseFromJson(Map<String, dynamic> json) => QuizResponse(
      quiz: QuizModel.fromJson(json['quiz'] as Map<String, dynamic>),
      answers: (json['answers'] as List<dynamic>)
          .map((e) => AnswerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuizResponseToJson(QuizResponse instance) =>
    <String, dynamic>{
      'quiz': instance.quiz,
      'answers': instance.answers,
    };
