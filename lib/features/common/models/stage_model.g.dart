// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stage_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StageModel _$StageModelFromJson(Map<String, dynamic> json) => StageModel(
      id: json['id'] as int,
      typeEducationId: json['typeEducationId'] as int,
      nameAr: json['nameAr'] as String,
      nameEng: json['nameEng'] as String,
      status: json['status'] as int,
      createdAt: json['createdAt'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$StageModelToJson(StageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typeEducationId': instance.typeEducationId,
      'nameAr': instance.nameAr,
      'nameEng': instance.nameEng,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'image': instance.image,
    };
