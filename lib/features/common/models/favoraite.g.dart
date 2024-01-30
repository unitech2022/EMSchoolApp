// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favoraite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteResponse _$FavoriteResponseFromJson(Map<String, dynamic> json) =>
    FavoriteResponse(
      favorite: Favorite.fromJson(json['favorite'] as Map<String, dynamic>),
      lesson: LessonModel.fromJson(json['lesson'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavoriteResponseToJson(FavoriteResponse instance) =>
    <String, dynamic>{
      'favorite': instance.favorite,
      'lesson': instance.lesson,
    };

Favorite _$FavoriteFromJson(Map<String, dynamic> json) => Favorite(
      id: json['id'] as int,
      userId: json['userId'] as String,
      lessonId: json['lessonId'] as int,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$FavoriteToJson(Favorite instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'lessonId': instance.lessonId,
      'createdAt': instance.createdAt,
    };
