// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_confirmation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CodeConfirmModel _$CodeConfirmModelFromJson(Map<String, dynamic> json) =>
    CodeConfirmModel(
      email: json['email'] as String?,
      code: json['code'] as int?,
      ok: json['ok'] as bool?,
      error: json['error'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$CodeConfirmModelToJson(CodeConfirmModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'code': instance.code,
      'ok': instance.ok,
      'error': instance.error,
      'id': instance.id,
    };
