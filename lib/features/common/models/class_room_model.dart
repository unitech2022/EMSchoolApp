import 'package:json_annotation/json_annotation.dart';
//dart run build_runner build
part 'class_room_model.g.dart';
@JsonSerializable()
class ClassRoomModel{

  final int id;
  final int stageId;
  final String nameAr;
  final String nameEng;
  final String image;
  final int status;
  final String createdAt;

  ClassRoomModel({required this.id, required this.stageId, required this.nameAr, required this.nameEng, required this.image, required this.status, required this.createdAt});


  factory ClassRoomModel.fromJson(Map<String, dynamic> json) =>
      _$ClassRoomModelFromJson(json);



  Map<String, dynamic> toJson() => _$ClassRoomModelToJson(this);


}