// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoModel _$PhotoModelFromJson(Map<String, dynamic> json) => PhotoModel(
      json['id'] as int?,
      json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      json['file'] as String,
      json['caption'] as String?,
      json['likes'] as int?,
      json['commentsNumber'] as int?,
      (json['comments'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : CommentsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['hashtags'] as List<dynamic>?)
          ?.map((e) => HashtagModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['createdAt'] as String?,
      json['updatedAt'] as String?,
      json['isMine'] as bool?,
      json['isDisliked'] as bool?,
      json['isLiked'] as bool?,
    );

Map<String, dynamic> _$PhotoModelToJson(PhotoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'file': instance.file,
      'caption': instance.caption,
      'likes': instance.likes,
      'commentsNumber': instance.commentsNumber,
      'comments': instance.comments,
      'hashtags': instance.hashtags,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'isMine': instance.isMine,
      'isDisliked': instance.isDisliked,
      'isLiked': instance.isLiked,
    };
