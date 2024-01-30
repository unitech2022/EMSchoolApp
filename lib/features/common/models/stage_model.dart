import 'package:json_annotation/json_annotation.dart';
//dart run build_runner build
part 'stage_model.g.dart';
@JsonSerializable()
class StageModel {

  final int id;
  final int typeEducationId;
  final String nameAr;
  final String nameEng;
  final int status;
  final String createdAt;
  final String image;

  StageModel({required this.id, required this.typeEducationId, required this.nameAr, required this.nameEng, required this.status, required this.createdAt, required this.image});


  factory StageModel.fromJson(Map<String, dynamic> json) =>
      _$StageModelFromJson(json);



  Map<String, dynamic> toJson() => _$StageModelToJson(this);
}