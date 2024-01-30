// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteModel _$NoteModelFromJson(Map<String, dynamic> json) => NoteModel(
      id: json['id'] as int,
      subjectId: json['subjectId'] as int,
      link: json['link'] as String,
      nameAr: json['nameAr'] as String,
      nameEng: json['nameEng'] as String,
      image: json['image'] as String,
      status: json['status'] as int,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$NoteModelToJson(NoteModel instance) => <String, dynamic>{
      'id': instance.id,
      'subjectId': instance.subjectId,
      'link': instance.link,
      'nameAr': instance.nameAr,
      'nameEng': instance.nameEng,
      'image': instance.image,
      'status': instance.status,
      'createdAt': instance.createdAt,
    };
