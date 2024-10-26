// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialog_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DialogModel _$DialogModelFromJson(Map<String, dynamic> json) => DialogModel(
      json['id'] as int,
      (json['users'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['messages'] as List<dynamic>)
          .map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['unreadTotal'] as int,
      json['createdAt'] as String,
      json['updatedAt'] as String?,
    );

Map<String, dynamic> _$DialogModelToJson(DialogModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'users': instance.users,
      'messages': instance.messages,
      'unreadTotal': instance.unreadTotal,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
