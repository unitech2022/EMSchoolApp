import 'package:em_school/features/common/models/lesson_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favoraite.g.dart';
@JsonSerializable()
class FavoriteResponse {
  final Favorite favorite;
  final LessonModel lesson;

  FavoriteResponse({required this.favorite, required this.lesson});

  // factory FavoriteResponse.fromJson(Map<String, dynamic> json) =>
  //     FavoriteResponse(
  //         favorite: Favorite.fromJson(json['favorite']),
  //         product: LessonModel.fromJson(json['lesson']));


  factory FavoriteResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoriteResponseFromJson(json);

}

@JsonSerializable()
class Favorite {
 final int id;
final  String userId;
 final int lessonId;

final  String createdAt;

  Favorite({required this.id, required this.userId, required this.lessonId, required this.createdAt});


 factory Favorite.fromJson(Map<String, dynamic> json) =>
     _$FavoriteFromJson(json);

  }

