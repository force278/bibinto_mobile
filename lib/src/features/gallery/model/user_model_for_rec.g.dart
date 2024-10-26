// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model_for_rec.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModelForRec _$UserModelForRecFromJson(Map<String, dynamic> json) =>
    UserModelForRec(
      avatar: json['avatar'] as String?,
      username: json['username'] as String,
      official: json['official'] as bool,
    );

Map<String, dynamic> _$UserModelForRecToJson(UserModelForRec instance) =>
    <String, dynamic>{
      'avatar': instance.avatar,
      'username': instance.username,
      'official': instance.official,
    };
