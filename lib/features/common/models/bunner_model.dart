
import 'package:json_annotation/json_annotation.dart';
//dart run build_runner build
part 'bunner_model.g.dart';
@JsonSerializable()
class BannerModel{

  final int id;
  final String image;
  final int status;
  final String createAte;

  BannerModel({required this.id, required this.image, required this.status, required this.createAte});

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);



  Map<String, dynamic> toJson() => _$BannerModelToJson(this);

}