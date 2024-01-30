// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_education_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeEducationModel _$TypeEducationModelFromJson(Map<String, dynamic> json) =>
    TypeEducationModel(
      id: json['id'] as int,
      nameAr: json['nameAr'] as String,
      nameEng: json['nameEng'] as String,
      status: json['status'] as int,
      createAte: json['createAte'] as String,
    );

Map<String, dynamic> _$TypeEducationModelToJson(TypeEducationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nameAr': instance.nameAr,
      'nameEng': instance.nameEng,
      'status': instance.status,
      'createAte': instance.createAte,
    };
