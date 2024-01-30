
import 'package:json_annotation/json_annotation.dart';
//dart run build_runner build
part 'type_education_model.g.dart';
@JsonSerializable()
class  TypeEducationModel {

  final int id;
  final String nameAr;
  final String nameEng;
  final int status;
  final String createAte;

  TypeEducationModel({required this.id, required this.nameAr, required this.nameEng, required this.status, required this.createAte});

  factory TypeEducationModel.fromJson(Map<String, dynamic> json) =>
      _$TypeEducationModelFromJson(json);



  Map<String, dynamic> toJson() => _$TypeEducationModelToJson(this);


}