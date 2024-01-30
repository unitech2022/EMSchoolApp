import 'package:json_annotation/json_annotation.dart';

//dart run build_runner build
part 'answer_model.g.dart';

@JsonSerializable()
class AnswerModel{

  final int id;
  final int quizId;
  final String textAr;
   final String textEng;
  final bool isCorrect;
  final int status;

  AnswerModel( {required this.id, required this.quizId, required this.textAr,required this.textEng, required this.isCorrect, required this.status});

  factory AnswerModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerModelFromJson(json);

}