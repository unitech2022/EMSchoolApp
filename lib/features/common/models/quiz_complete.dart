import 'package:freezed_annotation/freezed_annotation.dart';
part 'quiz_complete.g.dart';
@JsonSerializable()
class QuizComplete {
  final int id;

  final String studantId;
  final int lessoinId;
  final int subjectId;
  final int result;
  @JsonKey(name: 'final')
  final int finalDegree;
  final int status;
  final String createdAt;

  QuizComplete(
      {required this.id,
      required this.studantId,
      required this.lessoinId,
      required this.subjectId,
      required this.result,
      required this.finalDegree,
      required this.status,
      required this.createdAt});

  factory QuizComplete.fromJson(Map<String, dynamic> json) =>
      _$QuizCompleteFromJson(json);
}
