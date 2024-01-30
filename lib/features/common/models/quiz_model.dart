import 'package:em_school/features/common/models/answer_model.dart';
import 'package:json_annotation/json_annotation.dart';
//dart run build_runner build
part 'quiz_model.g.dart';

@JsonSerializable()
class QuizModel {

  final int id;
  final int lessonId;
  final String descAr;
  final String descEng;
  final String? file;
  final int type;

  QuizModel(
      {required this.id,
      required this.lessonId,

      required this.descAr,
      required this.descEng,
      required this.file,
      required this.type});

  factory QuizModel.fromJson(Map<String, dynamic> json) =>
      _$QuizModelFromJson(json);
}

@JsonSerializable()
class QuizResponse{
  final QuizModel quiz;
  final List<AnswerModel>answers;
  // final AnswerModel answerCorrect;

  QuizResponse({required this.quiz, required this.answers});

  factory QuizResponse.fromJson(Map<String, dynamic> json) =>
      _$QuizResponseFromJson(json);
}
