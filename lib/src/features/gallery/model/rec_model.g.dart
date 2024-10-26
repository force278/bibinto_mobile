// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rec_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecModel _$RecModelFromJson(Map<String, dynamic> json) => RecModel(
      id: json['id'] as int,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      file: json['file'] as String,
      caption: json['caption'] as String?,
      likes: json['likes'] as int,
      commentsNumber: json['commentsNumber'] as int?,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : CommentsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      hashtags: json['hashtags'] as List<dynamic>?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String?,
      isMine: json['isMine'] as bool,
      isDisliked: json['isDisliked'] as bool,
      isLiked: json['isLiked'] as bool,
    );

Map<String, dynamic> _$RecModelToJson(RecModel instance) => <String, dynamic>{
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
