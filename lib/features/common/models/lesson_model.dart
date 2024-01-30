import 'package:em_school/features/common/models/quiz_model.dart';
import 'package:em_school/features/common/models/reply_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'comment_model.dart';
//dart run build_runner build
part 'lesson_model.g.dart';
@JsonSerializable()
class LessonModel {
final int id;
final int unitId;
final String nameAr;
final String nameEng;
final String descAr;
final String descEng;
final String linkVidio;
final String image;
final bool isComplated;
final int status;
final int views;
final int liks;
final double rate;
final int subjectId;
final String createdAt;

  LessonModel({required this.id,
    required this.unitId,
    required this.nameAr,
    required this.nameEng,
    required this.descAr,
    required this.descEng,
    required this.linkVidio,
    required this.subjectId,
    required this.image,
    required this.views,
    required this.isComplated,
    required this.status,
      required this.liks,
           required this.rate,
    required this.createdAt});

factory LessonModel.fromJson(Map<String, dynamic> json) =>
    _$LessonModelFromJson(json);



Map<String, dynamic> toJson() => _$LessonModelToJson(this);
}


@JsonSerializable()
class LessonDetailsResponse{
  final LessonModel lesson;
  final List<CommentResponse> comments;
  final List<ReplayResponse> replies;
  final List<QuizResponse> quizes;
  final bool liked;

  LessonDetailsResponse({required this.lesson,required this.liked, required this.comments, required this.replies,required this.quizes});


  factory LessonDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$LessonDetailsResponseFromJson(json);
}