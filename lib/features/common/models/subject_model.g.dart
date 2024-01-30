// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectModel _$SubjectModelFromJson(Map<String, dynamic> json) => SubjectModel(
      id: json['id'] as int,
      progress: (json['progress'] as num).toDouble(),
      typeEducationId: json['typeEducationId'] as int,
      stageId: json['stageId'] as int,
      classRoomId: json['classRoomId'] as int,
      nameAr: json['nameAr'] as String,
      nameEng: json['nameEng'] as String,
      image: json['image'] as String,
      status: json['status'] as int,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$SubjectModelToJson(SubjectModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typeEducationId': instance.typeEducationId,
      'stageId': instance.stageId,
      'classRoomId': instance.classRoomId,
      'nameAr': instance.nameAr,
      'nameEng': instance.nameEng,
      'image': instance.image,
      'status': instance.status,
      'progress': instance.progress,
      'createdAt': instance.createdAt,
    };
