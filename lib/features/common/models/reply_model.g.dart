// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplayModel _$ReplayModelFromJson(Map<String, dynamic> json) => ReplayModel(
      id: json['id'] as int,
      commentId: json['commentId'] as int,
      userId: json['userId'] as String,
      text: json['text'] as String,
      status: json['status'] as int,
      createAte: json['createAte'] as String,
    );

Map<String, dynamic> _$ReplayModelToJson(ReplayModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'commentId': instance.commentId,
      'userId': instance.userId,
      'text': instance.text,
      'status': instance.status,
      'createAte': instance.createAte,
    };

ReplayResponse _$ReplayResponseFromJson(Map<String, dynamic> json) =>
    ReplayResponse(
      userDetail:
          UserModel.fromJson(json['userDetail'] as Map<String, dynamic>),
      reply: ReplayModel.fromJson(json['reply'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReplayResponseToJson(ReplayResponse instance) =>
    <String, dynamic>{
      'userDetail': instance.userDetail,
      'reply': instance.reply,
    };
