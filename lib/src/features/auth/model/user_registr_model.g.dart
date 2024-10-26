// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_registr_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegistrModel _$UserRegistrModelFromJson(Map<String, dynamic> json) =>
    UserRegistrModel(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      gender: json['gender'] as int?,
      avatar: json['avatar'] as String?,
      bio: json['bio'] as String?,
      birthDate: json['birthDate'] as String?,
      ok: json['ok'] as bool?,
      error: json['error'] as String?,
      id: json['id'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$UserRegistrModelToJson(UserRegistrModel instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'gender': instance.gender,
      'avatar': instance.avatar,
      'bio': instance.bio,
      'birthDate': instance.birthDate,
      'ok': instance.ok,
      'error': instance.error,
      'id': instance.id,
      'token': instance.token,
    };
