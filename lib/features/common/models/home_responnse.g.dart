// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_responnse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeResponse _$HomeResponseFromJson(Map<String, dynamic> json) => HomeResponse(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      bunners: (json['bunners'] as List<dynamic>)
          .map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      subjects: (json['subjects'] as List<dynamic>)
          .map((e) => SubjectModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      entertainments: (json['entertainments'] as List<dynamic>)
          .map((e) => EntertainmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      favorites: (json['favorites'] as List<dynamic>)
          .map((e) => Favorite.fromJson(e as Map<String, dynamic>))
          .toList(),
      scheduleResponses: (json['scheduleResponses'] as List<dynamic>)
          .map((e) => ScheduleResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      alerts: (json['alerts'] as List<dynamic>)
          .map((e) => AlertModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeResponseToJson(HomeResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
      'bunners': instance.bunners,
      'subjects': instance.subjects,
      'entertainments': instance.entertainments,
      'scheduleResponses': instance.scheduleResponses,
      'alerts': instance.alerts,
      'favorites': instance.favorites,
    };
