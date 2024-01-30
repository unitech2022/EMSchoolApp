// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleModel _$ScheduleModelFromJson(Map<String, dynamic> json) =>
    ScheduleModel(
      id: json['id'] as int,
      typeEducationId: json['typeEducationId'] as int,
      stageId: json['stageId'] as int,
      classRoomId: json['classRoomId'] as int,
      nameAr: json['nameAr'] as String,
      nameEng: json['nameEng'] as String,
      status: json['status'] as int,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$ScheduleModelToJson(ScheduleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typeEducationId': instance.typeEducationId,
      'stageId': instance.stageId,
      'classRoomId': instance.classRoomId,
      'nameAr': instance.nameAr,
      'nameEng': instance.nameEng,
      'status': instance.status,
      'createdAt': instance.createdAt,
    };

ScheduleResponse _$ScheduleResponseFromJson(Map<String, dynamic> json) =>
    ScheduleResponse(
      schedule:
          ScheduleModel.fromJson(json['schedule'] as Map<String, dynamic>),
      sessions: (json['sessions'] as List<dynamic>)
          .map((e) => SessionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScheduleResponseToJson(ScheduleResponse instance) =>
    <String, dynamic>{
      'schedule': instance.schedule,
      'sessions': instance.sessions,
    };
