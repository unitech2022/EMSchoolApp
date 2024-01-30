import 'package:json_annotation/json_annotation.dart';
//dart run build_runner build
part 'entertainment_model.g.dart';
@JsonSerializable()
class EntertainmentModel{

  final int id;
  final String image;
  final String link;
  final String nameAr;
  final String nameEng;
  final int status;
  final String createAte;

  EntertainmentModel({required this.id, required this.image, required this.link, required this.status, required this.createAte,

    required this.nameAr, required this.nameEng
  });

  factory EntertainmentModel.fromJson(Map<String, dynamic> json) =>
      _$EntertainmentModelFromJson(json);



  Map<String, dynamic> toJson() => _$EntertainmentModelToJson(this);
}