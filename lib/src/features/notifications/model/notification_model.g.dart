// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      like: json['like'] == null
          ? null
          : LikeModel.fromJson(json['like'] as Map<String, dynamic>),
      comment: json['comment'] == null
          ? null
          : CommentsModel.fromJson(json['comment'] as Map<String, dynamic>),
      sub: json['sub'] == null
          ? null
          : UserModel.fromJson(json['sub'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'like': instance.like,
      'comment': instance.comment,
      'sub': instance.sub,
    };
