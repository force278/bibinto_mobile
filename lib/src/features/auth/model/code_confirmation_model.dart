import 'package:json_annotation/json_annotation.dart';

part 'code_confirmation_model.g.dart';

@JsonSerializable()
class CodeConfirmModel {
  final String? email;
  final int? code;
  final bool? ok;
  final String? error;
  final String? id;

  CodeConfirmModel({
    this.email,
    this.code,
    this.ok,
    this.error,
    this.id,
  });

  factory CodeConfirmModel.fromJson(Map<String, dynamic> json) =>
      _$CodeConfirmModelFromJson(json);

  Map<String, dynamic> toJson() => _$CodeConfirmModelToJson(this);
}
