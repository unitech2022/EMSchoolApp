// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitModel _$UnitModelFromJson(Map<String, dynamic> json) => UnitModel(
      id: json['id'] as int,
      courseId: json['courseId'] as int,
      nameAr: json['nameAr'] as String,
      nameEng: json['nameEng'] as String,
      imageUrl: json['imageUrl'] as String,
      status: json['status'] as int,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$UnitModelToJson(UnitModel instance) => <String, dynamic>{
      'id': instance.id,
      'courseId': instance.courseId,
      'nameAr': instance.nameAr,
      'nameEng': instance.nameEng,
      'imageUrl': instance.imageUrl,
      'status': instance.status,
      'createdAt': instance.createdAt,
    };

UnitResponse _$UnitResponseFromJson(Map<String, dynamic> json) => UnitResponse(
      unitModel: UnitModel.fromJson(json['unitModel'] as Map<String, dynamic>),
      lessons: (json['lessons'] as List<dynamic>)
          .map((e) => LessonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UnitResponseToJson(UnitResponse instance) =>
    <String, dynamic>{
      'unitModel': instance.unitModel,
      'lessons': instance.lessons,
    };
