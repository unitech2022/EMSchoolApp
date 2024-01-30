// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bunner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) => BannerModel(
      id: json['id'] as int,
      image: json['image'] as String,
      status: json['status'] as int,
      createAte: json['createAte'] as String,
    );

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'status': instance.status,
      'createAte': instance.createAte,
    };
