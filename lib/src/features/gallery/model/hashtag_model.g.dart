// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hashtag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HashtagModel _$HashtagModelFromJson(Map<String, dynamic> json) => HashtagModel(
      id: json['id'] as int,
      hashtag: json['hashtag'] as String,
      photos: (json['photos'] as List<dynamic>)
          .map((e) => PhotoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPhotos: json['totalPhotos'] as int,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$HashtagModelToJson(HashtagModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hashtag': instance.hashtag,
      'photos': instance.photos,
      'totalPhotos': instance.totalPhotos,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
