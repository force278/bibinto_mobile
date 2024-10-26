// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikeModel _$LikeModelFromJson(Map<String, dynamic> json) => LikeModel(
      json['id'] as int,
      json['photo'] == null
          ? null
          : PhotoModel.fromJson(json['photo'] as Map<String, dynamic>),
      json['value'] as int?,
      UserModel.fromJson(json['user'] as Map<String, dynamic>),
      json['createdAt'] as String?,
      json['read'] as bool?,
    );

Map<String, dynamic> _$LikeModelToJson(LikeModel instance) => <String, dynamic>{
      'id': instance.id,
      'photo': instance.photo,
      'value': instance.value,
      'user': instance.user,
      'createdAt': instance.createdAt,
      'read': instance.read,
    };
