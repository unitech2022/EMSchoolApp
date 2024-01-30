// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassRoomModel _$ClassRoomModelFromJson(Map<String, dynamic> json) =>
    ClassRoomModel(
      id: json['id'] as int,
      stageId: json['stageId'] as int,
      nameAr: json['nameAr'] as String,
      nameEng: json['nameEng'] as String,
      image: json['image'] as String,
      status: json['status'] as int,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$ClassRoomModelToJson(ClassRoomModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'stageId': instance.stageId,
      'nameAr': instance.nameAr,
      'nameEng': instance.nameEng,
      'image': instance.image,
      'status': instance.status,
      'createdAt': instance.createdAt,
    };
