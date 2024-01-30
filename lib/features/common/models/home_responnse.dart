import 'package:em_school/features/common/models/alert_model.dart';
import 'package:em_school/features/common/models/favoraite.dart';
import 'package:em_school/features/common/models/schedule_model.dart';
import 'package:em_school/features/common/models/subject_model.dart';
import 'package:em_school/features/common/models/user_model.dart';

import 'bunner_model.dart';
import 'entertainment_model.dart';

import 'package:json_annotation/json_annotation.dart';
//dart run build_runner build
part 'home_responnse.g.dart';
@JsonSerializable()
class HomeResponse {
  final UserModel user;
 final List<BannerModel> bunners;
 final List<SubjectModel> subjects;
 final List<EntertainmentModel> entertainments;
  final List<ScheduleResponse> scheduleResponses;
  final List<AlertModel> alerts;
  final List<Favorite>   favorites;

  HomeResponse({required this.user, required this.bunners, required this.subjects, required this.entertainments,required this.favorites,

   required this.scheduleResponses, required this.alerts
  });
  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);



  // Map<String, dynamic> toJson() => _$HomeResponseToJson(this);

}