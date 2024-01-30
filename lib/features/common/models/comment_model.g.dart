// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      id: json['id'] as int,
      lessonId: json['lessonId'] as int,
      userId: json['userId'] as String,
      text: json['text'] as String,
      status: json['status'] as int,
      createAte: json['createAte'] as String,
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lessonId': instance.lessonId,
      'userId': instance.userId,
      'text': instance.text,
      'status': instance.status,
      'createAte': instance.createAte,
    };

CommentResponse _$CommentResponseFromJson(Map<String, dynamic> json) =>
    CommentResponse(
      userDetail:
          UserModel.fromJson(json['userDetail'] as Map<String, dynamic>),
      comment: CommentModel.fromJson(json['comment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentResponseToJson(CommentResponse instance) =>
    <String, dynamic>{
      'userDetail': instance.userDetail,
      'comment': instance.comment,
    };
