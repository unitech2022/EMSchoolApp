//dart run build_runner build
import 'package:freezed_annotation/freezed_annotation.dart';

part 'alert_model.g.dart';
@JsonSerializable()
class AlertModel {
  final int id;
  final String userId;
  final String titleAr;
  final String titleEng;
  final String descriptionAr;
  final String descriptionEng;
  final bool viewed;
  final int pageId;
  final int type;
  final String createdAt;

  AlertModel(
      {required this.id,
      required this.userId,
      required this.titleAr,
      required this.titleEng,
      required this.descriptionAr,
      required this.descriptionEng,
      required this.viewed,
      required this.pageId,
      required this.type,
      required this.createdAt});

  factory AlertModel.fromJson(Map<String, dynamic> json) =>
      _$AlertModelFromJson(json);

}
