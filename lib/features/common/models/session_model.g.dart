// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionModel _$SessionModelFromJson(Map<String, dynamic> json) => SessionModel(
      id: json['id'] as int,
      scheduleId: json['scheduleId'] as int,
      nameAr: json['nameAr'] as String,
      nameEng: json['nameEng'] as String,
      status: json['status'] as int,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$SessionModelToJson(SessionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scheduleId': instance.scheduleId,
      'nameAr': instance.nameAr,
      'nameEng': instance.nameEng,
      'status': instance.status,
      'createdAt': instance.createdAt,
    };
