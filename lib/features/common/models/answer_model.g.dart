// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerModel _$AnswerModelFromJson(Map<String, dynamic> json) => AnswerModel(
      id: json['id'] as int,
      quizId: json['quizId'] as int,
      textAr: json['textAr'] as String,
      textEng: json['textEng'] as String,
      isCorrect: json['isCorrect'] as bool,
      status: json['status'] as int,
    );

Map<String, dynamic> _$AnswerModelToJson(AnswerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quizId': instance.quizId,
      'textAr': instance.textAr,
      'textEng': instance.textEng,
      'isCorrect': instance.isCorrect,
      'status': instance.status,
    };
