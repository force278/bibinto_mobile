import 'package:json_annotation/json_annotation.dart';

part 'error_model.g.dart';

@JsonSerializable()
class ErrorModel {
  final bool ok;
  final String? error;
  final int? id;

  ErrorModel({required this.ok, this.error, this.id});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      ok: json['ok'],
      error: json['error'],
      id: json['id'],
    );
  }
}
