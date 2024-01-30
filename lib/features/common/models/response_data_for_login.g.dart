// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_data_for_login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseDataForLogin _$ResponseDataForLoginFromJson(
        Map<String, dynamic> json) =>
    ResponseDataForLogin(
      typeEducations: (json['typeEducations'] as List<dynamic>)
          .map((e) => TypeEducationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      stages: (json['stages'] as List<dynamic>)
          .map((e) => StageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      classRooms: (json['classRooms'] as List<dynamic>)
          .map((e) => ClassRoomModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      subjects: (json['subjects'] as List<dynamic>)
          .map((e) => SubjectModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseDataForLoginToJson(
        ResponseDataForLogin instance) =>
    <String, dynamic>{
      'typeEducations': instance.typeEducations,
      'stages': instance.stages,
      'classRooms': instance.classRooms,
      'subjects': instance.subjects,
    };
