// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      admin: json['admin'] as bool?,
      avatar: json['avatar'] as String?,
      bio: json['bio'] as String?,
      createdAt: json['createdAt'] as String?,
      firstName: json['firstName'] as String?,
      email: json['email'] as String?,
      id: json['id'] as int?,
      isMe: json['isMe'] as bool? ?? false,
      username: json['username'] as String,
      isFollowing: json['isFollowing'] as bool?,
      lastName: json['lastName'] as String?,
      official: json['official'] as bool?,
      totalFollowers: json['totalFollowers'] as int? ?? 0,
      totalFollowing: json['totalFollowing'] as int? ?? 0,
      updatedAt: json['updatedAt'] as String?,
      phone: json['phone'] as int?,
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => PhotoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      read: json['read'] as bool?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'admin': instance.admin,
      'avatar': instance.avatar,
      'bio': instance.bio,
      'createdAt': instance.createdAt,
      'firstName': instance.firstName,
      'email': instance.email,
      'id': instance.id,
      'isMe': instance.isMe,
      'username': instance.username,
      'isFollowing': instance.isFollowing,
      'lastName': instance.lastName,
      'official': instance.official,
      'totalFollowers': instance.totalFollowers,
      'totalFollowing': instance.totalFollowing,
      'updatedAt': instance.updatedAt,
      'phone': instance.phone,
      'photos': instance.photos,
      'read': instance.read,
    };
