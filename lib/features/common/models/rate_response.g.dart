// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RateResponse _$RateResponseFromJson(Map<String, dynamic> json) => RateResponse(
      rate: RateModel.fromJson(json['rate'] as Map<String, dynamic>),
      message: json['message'] as String,
    );

Map<String, dynamic> _$RateResponseToJson(RateResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'rate': instance.rate,
    };

RateModel _$RateModelFromJson(Map<String, dynamic> json) => RateModel(
      id: json['id'] as int,
      lessonId: json['lessonId'] as int,
      userId: json['userId'] as String,
      comment: json['comment'] as String,
      stare: json['stare'] as int,
      createAte: json['createAte'] as String,
    );

Map<String, dynamic> _$RateModelToJson(RateModel instance) => <String, dynamic>{
      'id': instance.id,
      'lessonId': instance.lessonId,
      'userId': instance.userId,
      'comment': instance.comment,
      'stare': instance.stare,
      'createAte': instance.createAte,
    };
