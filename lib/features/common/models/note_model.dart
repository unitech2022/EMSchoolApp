import 'package:json_annotation/json_annotation.dart';
//dart run build_runner build
part 'note_model.g.dart';
@JsonSerializable()
class NoteModel {
  final int id;
  final int subjectId;
  final String link;
  final String nameAr;
  final String nameEng;
  final String image;
  final int status;
  final String createdAt;

  NoteModel({required this.id,
    required this.subjectId, required this.link,
    required this.nameAr, required this.nameEng,
    required this.image,
    required this.status,
    required this.createdAt});

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);



  Map<String, dynamic> toJson() => _$NoteModelToJson(this);
}