//dart run build_runner build
import 'package:json_annotation/json_annotation.dart';

part 'rate_response.g.dart';

@JsonSerializable()
class RateResponse {
  final String message;
  final RateModel rate;


  RateResponse({required this.rate, required this.message});
  factory RateResponse.fromJson(Map<String, dynamic> json) =>
      _$RateResponseFromJson(json);
}
@JsonSerializable()
class RateModel {
  final int id;
  final int lessonId;
  final String userId;
  final String comment;
  final int stare;
  final String createAte;

  RateModel(
      {required this.id,
      required this.lessonId,
      required this.userId,
      required this.comment,
      required this.stare,
      required this.createAte});

        factory RateModel.fromJson(Map<String, dynamic> json) =>
      _$RateModelFromJson(json);
}
