// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      userName: json['userName'] as String,
      role: json['role'] as String,
      subjectId: json['subjectId'] as int,
      fullName: json['fullName'] as String,
      uniqCode: json['uniqCode'] as String,
      deviceToken: json['deviceToken'] as String?,
      profileImage: json['profileImage'] as String?,
      status: json['status'] as int,
      code: json['code'] as String,
      studantId: json['studantId'] as int?,
      typeEducationId: json['typeEducationId'] as int,
      stageId: json['stageId'] as int,
      classRoomId: json['classRoomId'] as int,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'role': instance.role,
      'fullName': instance.fullName,
      'uniqCode': instance.uniqCode,
      'deviceToken': instance.deviceToken,
      'profileImage': instance.profileImage,
      'status': instance.status,
      'code': instance.code,
      'studantId': instance.studantId,
      'typeEducationId': instance.typeEducationId,
      'stageId': instance.stageId,
      'subjectId': instance.subjectId,
      'classRoomId': instance.classRoomId,
    };
